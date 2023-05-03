BEGIN {
  skill_count = 0
  experience_count = 0
  education_count = 0
  state = "find_name"
}

NF == 0 { 
  # Skip blank lines
  next
}

/^=/ {
  # Skip markdown headings
  next
}

state == "find_name" {
  heading_name = $0
  state = "find_location"
  next
}

state == "find_location" {
  heading_location = $0
  state = "find_phone"
  next
}

state == "find_phone" {
  heading_phone = $0
  state = "find_email"
  next
}

state == "find_email" {
  heading_email = $0
  state = "find_summary_heading"
  next
}

/SUMMARY/ {
  state = "find_summary"
  next
}

/WORK HISTORY/ {
  state = "find_experience_date"
  next
}

state == "find_summary" {
  if (summary == "") {
    summary = $0
  } else {
    summary = summary " " $0
  }
  next
}

state == "find_experience_bullets" && / - / {
  # Encountered date-like line while parsing an experience section
  state = "find_experience_date"
}

state == "find_experience_date" {
  experience_count++
  experience[experience_count, "date"] = $0
  state = "find_experience_org"
  next
}

state == "find_experience_org" {
  split($0, org_name_location, / - /)
  experience[experience_count, "org"] = org_name_location[1]
  experience[experience_count, "location"] = org_name_location[2]
  state = "find_experience_title"
  next
}

state == "find_experience_title" {
  experience[experience_count, "title"] = $0
  state = "find_experience_bullets"
  next
}

/SKILLS/ {
  state = "find_skills"
  next
}

state == "find_experience_bullets" && /^(\+|*)/ {
  bullet_count = experience[experience_count, "bullet_count"]
  if (bullet_count) {
    bullet_count++
  } else {
    bullet_count = 1
  }
  experience[experience_count, "bullet_count"] = bullet_count
  # Experience bullets start with a list character
  experience[experience_count, "bullets", bullet_count] = $0
  next
}

state == "find_experience_bullets" {
  bullet_count = experience[experience_count, "bullet_count"]
  bullet = experience[experience_count, "bullets", bullet_count]
  experience[experience_count, "bullets", bullet_count] = bullet " " $0
  next
}

/EDUCATION/ {
  state = "find_education_institution_location"
  next
}

state == "find_skills" {
  skills[skill_count] = $0
  skill_count++
  next
}

state == "find_education_institution_location" {
  split($0, education_institution_location, / - /)
  education_institution[education_count] = education_institution_location[1]
  education_location[education_count] = education_institution_location[2]
  state = "find_education_degree"
  next
}

state == "find_education_degree" {
  education_degree[education_count] = $0
  state = "find_education_date"
  next
}

state == "find_education_date" {
  education_date[education_count] = $0
  # Increment education count for the next education
  education_count++
  # Look for another education
  state = "find_education_institution_location"
  next
}

END {
  printf "{\n"
  printf "  \"name\": \"%s\",\n", heading_name
  printf "  \"location\": \"%s\",\n", heading_location
  printf "  \"phone\": \"%s\",\n", heading_phone
  printf "  \"email\": \"%s\",\n", heading_email
  printf "  \"summary\": \"%s\",\n", summary
  printf "  \"experience\": [\n"
  for (exp_idx = 1; exp_idx <= experience_count; exp_idx++) {
    printf "    {\n"
    printf "      \"date\": \"%s\",\n", experience[exp_idx, "date"]
    printf "      \"name\": \"%s\",\n", experience[exp_idx, "org"]
    printf "      \"location\": \"%s\",\n", experience[exp_idx, "location"]
    printf "      \"title\": \"%s\":\n", experience[exp_idx, "title"]
    printf "      \"bullets\": [\n"
    bullet_count = experience[exp_idx, "bullet_count"]
    for (bullet_idx = 1; bullet_idx <= bullet_count; bullet_idx++) {
      bullet = experience[exp_idx, "bullets", bullet_idx]
      if (bullet_idx < bullet_count) {
        # If there's another bullet, render a separator
        printf "        \"%s\",\n", bullet
      } else {
        printf "        \"%s\"\n", bullet
      }
    }
    printf "      ]\n"
    if (exp_idx < experience_count) {
      # If there's another experience, render a separator
      printf "    },\n"
    } else {
      printf "    }\n"
    }
  }
  printf "  ],\n"
  printf "  \"skills\": [\n"
  for (skill_idx in skills) {
    if ((skill_idx + 1) in skills) {
      # If there's another skill, render a separator
      printf "    \"%s\",\n", skills[skill_idx]
    } else {
      printf "    \"%s\"\n", skills[skill_idx]
    }
  }
  printf "  ],\n"
  printf "  \"education\": [\n"
  for (education_idx in education_date) {
    printf "    {\n"
    printf "      \"institution\": \"%s\",\n", education_institution[education_idx]
    printf "      \"location\": \"%s\",\n", education_location[education_idx]
    printf "      \"degree\": \"%s\",\n", education_degree[education_idx]
    printf "      \"date\": \"%s\"\n", education_date[education_idx]
    if ((education_idx + 1) in education_date) {
      # If there's another education, render a separator
      printf "    },\n"
    } else {
      printf "    }\n"
    }
  }
  printf "  ]\n"
  printf "}\n"
}
