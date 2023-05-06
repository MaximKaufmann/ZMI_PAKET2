*"* use this source file for your ABAP unit test classes
CLASS test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
.
*?<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>test
*?</TEST_CLASS>
*?<TEST_MEMBER>f_Cut
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>ZMB_SICF_HANDLER
*?</OBJECT_UNDER_TEST>
*?<OBJECT_IS_LOCAL/>
*?<GENERATE_FIXTURE/>
*?<GENERATE_CLASS_FIXTURE/>
*?<GENERATE_INVOCATION>X
*?</GENERATE_INVOCATION>
*?<GENERATE_ASSERT_EQUAL>X
*?</GENERATE_ASSERT_EQUAL>
*?</TESTCLASS_OPTIONS>
*?</asx:values>
*?</asx:abap>
  PRIVATE SECTION.
    DATA:
      f_Cut TYPE REF TO zmi_dyncl.  "class under test

    METHODS: handle_Request FOR TESTING.
ENDCLASS.       "test


CLASS test IMPLEMENTATION.

  METHOD handle_Request.
    DATA: lv_http_status TYPE i.
    DATA: lv_status_text TYPE string.
    DATA(lv_url) = |https://obd.in4md-service.de/zlhind/zmb_sicf_handle?sap-client=500|.

    DATA: o_client TYPE REF TO if_http_client.
    TRY.
* Client-Objekt erzeugen
        cl_http_client=>create_by_url( EXPORTING
                                       url     = lv_url
                                     IMPORTING
                                       client  = o_client ).

        o_client->authenticate( username = 'TEACH-000' password = 'tlestart!').
        o_client->send( timeout = if_http_client=>co_timeout_default ).
* Response lesen
        o_client->receive( ).
* HTTP Return Code holen
        o_client->response->get_status( IMPORTING
                                          code   = lv_http_status
                                          reason = lv_status_text ).

        IF lv_http_status = 200.
* HTTP Body als Character-Daten
          DATA(lv_result) = o_client->response->get_cdata( ).
          cl_abap_unit_assert=>assert_equals( act = lv_result exp = 'Hello World').
        ELSE.
          cl_abap_unit_assert=>fail(  ).
        ENDIF.

* HTTP Connection schließen
        o_client->close( ).

      CATCH cx_root INTO DATA(e_txt).
        WRITE: / e_txt->get_text( ).
        cl_abap_unit_assert=>fail(  ).
    ENDTRY.


  ENDMETHOD.
endclass.
