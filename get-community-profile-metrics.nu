#!/usr/bin/env nu

def main [owner: string, repo: string] {
  let response = gh api $"/repos/($owner)/($repo)/community/profile"
  | from json

  $response
  | select health_percentage description documentation updated_at
  | transpose key value
  | to csv
  | save community-profile-metrics.csv

  $response
  | get files
  | select code_of_conduct code_of_conduct_file contributing issue_template pull_request_template license
  | transpose key value
  | to csv
  | save community-profile-metrics-file.csv

  $response
  | get files.readme
  | select url html_url
  | transpose key value
  | to csv
  | save community-profile-metrics-file-readme.csv

  return
}
