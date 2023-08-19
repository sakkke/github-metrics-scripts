#!/usr/bin/env nu

def main [owner: string, repo: string] {
  let response = gh api $"/repos/($owner)/($repo)/stats/commit_activity" | from json

  if ($response | is-empty) {
    print 'Requesting again after 5 seconds. Waiting...'
    sleep 5sec
    main $owner $repo
    return
  }

  $response
  | each {|it|
    $it | select total week
  }
  | save -f last-year-of-commit-activity.csv

  $response
  | each {|it|
    let days = $it.days

    {
      sun: $days.0
      mon: $days.1
      tue: $days.2
      wed: $days.3
      thu: $days.4
      fri: $days.5
      sat: $days.6
    }
  }
  | save -f last-year-of-commit-activity-days.csv
}
