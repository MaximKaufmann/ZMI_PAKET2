INTERFACE z_if_calc_vat_001
  PUBLIC .
  METHODS get_vat
    IMPORTING
      !iv_amount      TYPE p
    EXPORTING
      !ev_amount_vat  TYPE p
      !ev_percent_vat TYPE p.
  INTERFACES if_badi_interface .
ENDINTERFACE.
