#!/usr/bin/env nu

def main [owner: string, repo: string] {
  let response = gh api $"/repos/($owner)/($repo)/stats/code_frequency"
  | from json

  if ($response | is-empty) {
    print 'Requesting again after 5 seconds. Waiting...'
    sleep 5sec
    main $owner $repo
    return
  }

  $response
  | each {|it|
    {
      time: $it.0
      additions: $it.1
      deletions: $it.2
    }
  }
  | save -f weekly-commit-activity.csv
}
