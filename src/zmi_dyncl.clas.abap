CLASS zmi_dyncl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES IF_HTTP_EXTENSION.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zmi_dyncl IMPLEMENTATION.
  METHOD if_http_extension~handle_request.
server->response->set_status( code = '200' reason = 'OK' ).
server->response->set_cdata( data = 'Hello World').
  ENDMETHOD.

ENDCLASS.


