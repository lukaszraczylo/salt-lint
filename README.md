# salt-lint

Linter for Salt configuration management.

Master: [![Master: Build Status](https://api.shippable.com/projects/551cfc825ab6cc1352b491b3/badge?branchName=master)](https://app.shippable.com/projects/551cfc825ab6cc1352b491b3/builds/latest)
Development: [![Development: Build Status](https://api.shippable.com/projects/551cfc825ab6cc1352b491b3/badge?branchName=development)](https://app.shippable.com/projects/551cfc825ab6cc1352b491b3/builds/latest)


[![Gem Version](https://badge.fury.io/rb/salt-lint.svg)](http://badge.fury.io/rb/salt-lint)
[![Code Climate](https://codeclimate.com/github/lukaszraczylo/salt-lint/badges/gpa.svg)](https://codeclimate.com/github/lukaszraczylo/salt-lint)
[![Gratipay](https://img.shields.io/gratipay/lukaszraczylo.svg)](https://gratipay.com/lukaszraczylo/)

## Documentation:
Please see [documentation](doc/list_tests.md) to interpret any results returned.

## Running within git repo with its git files only

```
git ls-files | grep sls | xargs -I {} salt-lint -f {}
```

## Do not use it until version >= 0.5
