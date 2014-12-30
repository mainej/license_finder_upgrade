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
`dependency_decisions.yml`.


## Finalization

1. Review `dependency_decisions.yml` for accuracy and completeness.  See the
   `license_finder` README for information about the format of the file.
2. Optionally, move `doc/dependency_decisions.yml`. The `license_finder`
   commands expect to find the file at `doc/dependency_decisions.yml` but can be
   passed `--decision_file`. If you don't want to pass this option all the time,
   you can add a `decisions_file` key to `config/license_finder.yml`.
3. Store `dependency_decisions.yml` in version control.
4. Delete `doc/dependencies.db`. It is not used by `license_finder` version
   2.0.
5. Delete all the other `doc/dependencies*` files, if you want.  If you
   want to keep some textual reports, see the `license_finder report` README
   docs.
6. Clean up your `config/license_finder.yml` file.  Remove the following keys
   from the YAML; their data has been copied to `doc/dependency_decisions.yml`
   or moved elsewhere:
   * `whitelist`
   * `ignore_dependencies`
   * `ignore_groups`
   * `project_name`
   * `dependencies_file_dir` (replaced with `decisions_file`)
7. Install `license_finder >= 2.0`.  After installing, when you run
   `license_finder` you should see the same list of action items you had before
   upgrading.


## Contributing

1. Fork it ( https://github.com/mainej/license_finder_upgrade/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
