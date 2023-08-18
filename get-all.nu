#!/usr/bin/env nu

def main [owner: string, repo: string] {
  let scripts = ls get-*.nu
  | get name
  | where $it != get-all.nu

  $scripts | each {|script|
    nu $script $owner $repo
  }

  return
}
