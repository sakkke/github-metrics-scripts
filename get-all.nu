#!/usr/bin/env nu

def main [owner: string, repo: string] {
  ./get-community-profile-metrics.nu $owner $repo
}
