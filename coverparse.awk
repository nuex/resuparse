BEGIN {
  state = "find_name"
}

state == "find_name" && NF > 0 {
  name = $0
  state = "find_street"
  next
}

state == "find_street" {
  street = $0
  state = "find_city"
  next
}

state == "find_city" {
  city = $0
  state = "find_phone"
  next
}

state == "find_phone" {
  phone = $0
  state = "find_email"
  next
}

state == "find_email" {
  email = $0
  state = "find_date"
  next
}

state == "find_date" && NF > 0 {
  date = $0
  state = "find_recipient_name"
  next
}

state == "find_recipient_name" && NF > 0 {
  recipient_name = $0
  state = "find_recipient_company"
  next
}

state == "find_recipient_company" {
  recipient_company = $0
  state = "find_recipient_street"
  next
}

state == "find_recipient_street" {
  recipient_street = $0
  state = "find_recipient_city"
  next
}

state == "find_recipient_city" {
  recipient_city = $0
  state = "find_opening"
  next
}

state == "find_opening" && NF > 0 {
  opening = $0
  state = "find_body"
  next
}

state == "find_body" && NF > 0 {
  body = $0
  state = "find_remaining_body"
  next
}

state == "find_remaining_body" && /,$/ {
  # If the line ends in a comma, this is likely the letter closing
  state = "find_closing"
}

state == "find_remaining_body" {
  # Concatenate lines of the letter body
  body = body "\\n" $0
}

state == "find_closing" {
  closing = $0
  state = "find_sender_name"
  next
}

state == "find_sender_name" && NF > 0 {
  sender_name = $0
  next
}

END {
  printf "{\n"
  printf "  \"name\": \"%s\",\n", name
  printf "  \"street\": \"%s\",\n", street
  printf "  \"city\": \"%s\",\n", city
  printf "  \"phone\": \"%s\",\n", phone
  printf "  \"email\": \"%s\",\n", email
  printf "  \"date\": \"%s\",\n", date
  printf "  \"recipient_name\": \"%s\",\n", recipient_name
  printf "  \"recipient_company\": \"%s\",\n", recipient_company
  printf "  \"recipient_street\": \"%s\",\n", recipient_street
  printf "  \"recipient_city\": \"%s\",\n", recipient_city
  printf "  \"opening\": \"%s\",\n", opening
  printf "  \"body\": \"%s\",\n", body
  printf "  \"closing\": \"%s\",\n", closing
  printf "  \"sender_name\": \"%s\"\n", sender_name
  printf "}\n"
}
