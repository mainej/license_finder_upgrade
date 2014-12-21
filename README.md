# license_finder_upgrade

`license_finder_upgrade` helps upgrade [`license_finder`](https://github.com/pivotal/LicenseFinder)
projects from version ~1.2 to 2.0.

[![Build Status](https://travis-ci.org/mainej/license_finder_upgrade.svg?branch=master)](https://travis-ci.org/mainej/license_finder_upgrade)
[![Code Climate](https://codeclimate.com/github/mainej/license_finder_upgrade/badges/gpa.svg)](https://codeclimate.com/github/mainej/license_finder_upgrade)

## Installation

1. Make sure you've upgraded to the latest version of `license_finder` _less
   than_ version 2.0. You can check this with `gem list --local license_finder`.
2. Run `license_finder` at least once with this lower version of
   `license_finder`.  This will ensure that the `license_finder` database is in a
   state which `license_finder_upgrade` understands.
3. Install with `gem install license_finder_upgrade`

## Usage

Run the command once, in your project directory:

    $ license_finder_upgrade

There should be no output, but a new file should exist in your `doc/` directory
(or whichever directory `license_finder` typically stores files in) called
`dependency_decisions.yml`.  You may want to review this file for accuracy and
completeness.  See the `license_finder` version 2 README for information about
storing this file in version control.

You can delete all the other `doc/dependencies*` files, if you want.  If you
want to keep some textual reports, see the version 2 `license_finder` README
docs about `license_finder report`.  You should at least delete
`doc/dependencies.db` since it is not used by `license_finder` version 2.0 and
up.

Now you can install `license_finder >= 2.0`.  After installing, when you run
`license_finder` you should see the same list of action items you had before
upgrading.

## Contributing

1. Fork it ( https://github.com/mainej/license_finder_upgrade/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
