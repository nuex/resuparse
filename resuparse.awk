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
  # Experience bullets start with a list character
  bullet_count = experience[experience_count, "bullet_count"]
  if (bullet_count) {
    # New experience bullet, increment count
    bullet_count++
  } else {
    # If no bullet count is set, this is the first bullet
    # First experience bullet, set count
    bullet_count = 1
  }
  # Store bullet count on experience array, to be used
  # by JSON template during render
  experience[experience_count, "bullet_count"] = bullet_count
  # Remove extranneous characters before text
  sub(/^[^[:alpha:]]*/, "", $0)
  # Assign the bullet
  experience[experience_count, "bullets", bullet_count] = $0
  next
}

state == "find_experience_bullets" {
  bullet_count = experience[experience_count, "bullet_count"]
  bullet = experience[experience_count, "bullets", bullet_count]
  # Remove extranneous characters before text
  sub(/^[^[:alpha:]]*/, "", $0)
  # The `find_experience_bullets` state is still active, but this is
  # not a new bullet. Append this line to the previous bullet.
  experience[experience_count, "bullets", bullet_count] = bullet " " $0
  next
}

/EDUCATION/ {
  state = "find_education_institution_location"
  next
}

state == "find_skills" {
  # New skill, increment count
  skill_count++
  skills[skill_count] = $0
  next
}

state == "find_education_institution_location" {
  # New education, increment count
  education_count++
  split($0, education_institution_location, / - /)
  education[education_count, "institution"] = education_institution_location[1]
  education[education_count, "location"] = education_institution_location[2]
  state = "find_education_degree"
  next
}

state == "find_education_degree" {
  education[education_count, "degree"] = $0
  state = "find_education_date"
  next
}

state == "find_education_date" {
  education[education_count, "date"] = $0
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
    printf "      \"title\": \"%s\",\n", experience[exp_idx, "title"]
    printf "      \"bullets\": [\n"
    bullet_count = experience[exp_idx, "bullet_count"]
    for (bullet_idx = 1; bullet_idx <= bullet_count; bullet_idx++) {
      bullet = experience[exp_idx, "bullets", bullet_idx]
      printf "        \"%s\"%s\n", bullet, (bullet_idx < bullet_count ? "," : "")
    }
    printf "      ]\n"
    printf "    }%s\n", (exp_idx < experience_count ? "," : "")
  }
  printf "  ],\n"
  printf "  \"skills\": [\n"
  for (skill_idx = 1; skill_idx <= skill_count; skill_idx++) {
    printf "    \"%s\"%s\n", skills[skill_idx], (skill_idx < skill_count ? "," : "")
  }
  printf "  ],\n"
  printf "  \"education\": [\n"
  for (education_idx = 1; education_idx <= education_count; education_idx++) {
    printf "    {\n"
    printf "      \"institution\": \"%s\",\n", education[education_idx, "institution"]
    printf "      \"location\": \"%s\",\n", education[education_idx, "location"]
    printf "      \"degree\": \"%s\",\n", education[education_idx, "degree"]
    printf "      \"date\": \"%s\"\n", education[education_idx, "date"]
    printf "    }%s\n", (education_idx < education_count ? "," : "")
  }
  printf "  ]\n"
  printf "}\n"
}
