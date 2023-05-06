*&---------------------------------------------------------------------*
*& Report z_ob_re_001_badi
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ob_re_001_badi.

DATA: handle TYPE REF TO z_badi_calc_vat_001,
sum TYPE p,
vat TYPE p,
percent TYPE p.
sum = 50.

GET BADI handle.

CALL BADI handle->get_vat
  EXPORTING
    iv_amount      = sum
  IMPORTING
    ev_amount_vat  = vat
    ev_percent_vat = percent.
WRITE: 'Prozent:', percent, 'Umsatzsteuer:', vat.
