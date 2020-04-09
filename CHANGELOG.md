Workarea Legacy Orders 2.0.2 (2020-04-09)
--------------------------------------------------------------------------------

*   Rename field for tender type

    This is a breaking change!

    Using a field of name `type` is incompatible with import/export, which
    was introduced in v2.0 of this plugin. This will be resolved in Workarea
    v3.6, but for now the best path to fix import/export is to rename
    this field.
    Ben Crouse



Workarea Legacy Orders 2.0.1 (2020-03-10)
--------------------------------------------------------------------------------

*   Include Workarea::ApplicationDocument for LegacyOrder embedded models

    LEGACYORDERS-5
    Matt Duffy



Workarea Legacy Orders 2.0.0 (2020-02-21)
--------------------------------------------------------------------------------

*   Update system test to not use Money object for string comparison

    LEGACYORDERS-4
    Matt Duffy

*   Add data structure to README

    LEGACYORDERS-3
    Matt Duffy

*   Add data fields to models for allowing storing additional information

    Matt Duffy

*   Update storefront view with legacy ordre specific appoint points

    LEGACYORDERS-2
    Matt Duffy

*   Add import/export behavior to legacy orders admin UI

    Matt Duffy

*   Improve legacy order integration

    * Add admin UI and searchability
    * Add legacy orders in user account summary
    * Update views and view models to align with regular orders
    * Include legacy orders in order lookup
    * Improve seeds

    LEGACYORDERS-1
    Matt Duffy



