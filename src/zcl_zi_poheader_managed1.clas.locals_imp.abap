CLASS lhc_ZC_ZI_POHEADER_MANAGED1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zc_zi_poheader_managed1 RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zc_zi_poheader_managed1 RESULT result.

    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE zc_zi_poheader_managed1.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE zc_zi_poheader_managed1.

    METHODS precheck_delete FOR PRECHECK
      IMPORTING keys FOR DELETE zc_zi_poheader_managed1.

    METHODS GetDefaultsForCreate FOR READ
      IMPORTING keys FOR FUNCTION zc_zi_poheader_managed1~GetDefaultsForCreate RESULT result.

    METHODS ponorel FOR MODIFY
      IMPORTING keys FOR ACTION zc_zi_poheader_managed1~ponorel RESULT result.

    METHODS porel FOR MODIFY
      IMPORTING keys FOR ACTION zc_zi_poheader_managed1~porel RESULT result.

    METHODS Static_ALL FOR MODIFY
      IMPORTING keys FOR ACTION zc_zi_poheader_managed1~Static_ALL RESULT result.

    METHODS migo_status_update FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zc_zi_poheader_managed1~migo_status_update.

    METHODS check_email FOR VALIDATE ON SAVE
      IMPORTING keys FOR zc_zi_poheader_managed1~check_email.

ENDCLASS.

CLASS lhc_ZC_ZI_POHEADER_MANAGED1 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD GetDefaultsForCreate.

    APPEND VALUE #( %cid = keys[ 1 ]-%cid %param-Bsart = 'ZNB' ) TO result.


  ENDMETHOD.

  METHOD precheck_create.



    LOOP AT entities INTO DATA(ls_enity).
      IF   ls_enity-Bukrs EQ '6000'.
        APPEND VALUE #( Ebeln = ls_enity-Ebeln ) TO failed-ZC_ZI_POHEADER_MANAGED1.
        APPEND VALUE #(
        Ebeln = ls_enity-Ebeln
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'Please enter correct Company Code' && ls_enity-Bukrs
               )

        ) TO reported-ZC_ZI_POHEADER_MANAGED1.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD check_email.

    DATA: lr_reg TYPE REF TO cl_abap_regex.
    DATA: lr_matcher TYPE REF TO cl_abap_matcher,
          lv_email   TYPE string.


    CREATE OBJECT lr_reg
      EXPORTING
        pattern     = '\w+(\.\w+)*@(\w+\.)+(\w{2,4})'
        ignore_case = abap_true.

    READ ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1 ALL FIELDS WITH VALUE #( FOR ls_key IN keys
      (    Ebeln = ls_key-Ebeln
    ) ) RESULT DATA(lt_validation).

    LOOP AT lt_validation INTO DATA(ls_validation).
      DATA(lv_po_count) = strlen( ls_validation-Email ).
      IF lv_po_count LT 10.
        APPEND VALUE #( Ebeln = ls_validation-Ebeln ) TO failed-ZC_ZI_POHEADER_MANAGED1.
        APPEND VALUE #( Ebeln = ls_validation-Ebeln
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'Pls enter correct length for Email' && ls_validation-Email
               )
        ) TO reported-ZC_ZI_POHEADER_MANAGED1.

      ENDIF.


      lr_matcher = lr_reg->create_matcher( text = ls_validation-Email ).
      IF lr_matcher->match( ) IS INITIAL.
        APPEND VALUE #( Ebeln = ls_validation-Ebeln ) TO failed-ZC_ZI_POHEADER_MANAGED1.
        APPEND VALUE #( Ebeln = ls_validation-Ebeln
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'Pls enter correct format for Email Id' && ls_validation-Email
               )
        ) TO reported-ZC_ZI_POHEADER_MANAGED1.

      ENDIF.

    ENDLOOP.




  ENDMETHOD.

  METHOD precheck_update.


    LOOP AT entities INTO DATA(ls_enity).
      IF   ls_enity-Bukrs EQ '6000'.
        APPEND VALUE #( Ebeln = ls_enity-Ebeln ) TO failed-ZC_ZI_POHEADER_MANAGED1.
        APPEND VALUE #(
        Ebeln = ls_enity-Ebeln
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'Please enter correct Company Code' && ls_enity-Bukrs
               )

        ) TO reported-ZC_ZI_POHEADER_MANAGED1.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD precheck_delete.

    READ ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1 ALL FIELDS WITH VALUE #( FOR ls_key IN keys
       (    Ebeln = ls_key-Ebeln
     ) ) RESULT DATA(lt_prechk_delete).


    LOOP AT lt_prechk_delete INTO DATA(ls_enity).
      IF   ls_enity-PoRelease EQ  abap_true.
        APPEND VALUE #( Ebeln = ls_enity-Ebeln ) TO failed-ZC_ZI_POHEADER_MANAGED1.
        APPEND VALUE #(
        Ebeln = ls_enity-Ebeln
        %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'You can not delete this line Item as PO release is X'
               )

        ) TO reported-ZC_ZI_POHEADER_MANAGED1.

      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD porel.
*  // We are reading PK from the Front end
*    READ ENTITY IN LOCAL MODE zc_mng_pohead_08
*    ALL FIELDS WITH VALUE #( FOR ls_key IN keys
*    ( Ebeln = ls_key-Ebeln ) ) RESULT DATA(lt_po_action).

*    LOOP AT lt_po_action ASSIGNING FIELD-SYMBOL(<fs_po_action>).
*
*
*      MODIFY ENTITY IN LOCAL MODE zc_mng_pohead_08
*      UPDATE FIELDS ( PoRelease )
*      WITH VALUE #( ( Ebeln = <fs_po_action>-Ebeln
*                    PoRelease = abap_true
*      )
*      ) REPORTED reported
*      FAILED failed.


   loop at keys ASSIGNING FIELD-SYMBOL(<fs_po_action>).

*      data(lv_popup_value) = <fs_po_action>-%param-po_release.
*      MODIFY ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1
*      UPDATE FIELDS ( PoRelease )
*      WITH VALUE #( ( Ebeln = <fs_po_action>-Ebeln
*                    PoRelease = lv_popup_value
*      )
*      ) REPORTED reported
*      FAILED failed.
*
*      READ ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1
*       ALL FIELDS WITH VALUE #( (  Ebeln = <fs_po_action>-Ebeln ) )
*       RESULT DATA(lt_result).
*
*      result = VALUE #( FOR ls_result IN lt_result
*      (
*        Ebeln = ls_result-Ebeln
*        %param-Ebeln = ls_result-Ebeln
*        %param-PoRelease = ls_result-PoRelease
*      )
*      ).
    ENDLOOP.
  ENDMETHOD.

  METHOD ponorel.
* We are reading PK from the Front end
    READ ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1
    ALL FIELDS WITH VALUE #( FOR ls_key IN keys
    ( Ebeln = ls_key-Ebeln ) ) RESULT DATA(lt_po_action).

    LOOP AT lt_po_action ASSIGNING FIELD-SYMBOL(<fs_po_action>).

      MODIFY ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1
      UPDATE FIELDS ( PoRelease )
      WITH VALUE #( ( Ebeln = <fs_po_action>-Ebeln
                    PoRelease = abap_false
      )
      ) REPORTED reported
      FAILED failed.

      READ ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1
       ALL FIELDS WITH VALUE #( (  Ebeln = <fs_po_action>-Ebeln ) )
       RESULT DATA(lt_result).

      result = VALUE #( FOR ls_result IN lt_result
      (
        Ebeln = ls_result-Ebeln
        %param-Ebeln = ls_result-Ebeln
        %param-PoRelease = ls_result-PoRelease
      )
      ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.
*    READ ENTITY IN LOCAL MODE zc_mng_pohead_08
*     ALL FIELDS WITH VALUE #( FOR ls_key IN keys
*     ( Ebeln = ls_key-Ebeln ) ) RESULT DATA(lt_dynamic_control).
*
*    result = VALUE #( FOR ls_dynamic_control IN lt_dynamic_control
*    (
*    Ebeln = ls_dynamic_control-Ebeln
*
*    %delete = COND #( WHEN ls_dynamic_control-PoRelease = abap_false
*                      THEN if_abap_behv=>fc-o-enabled
*                      ELSE if_abap_behv=>fc-o-disabled
*
*
*    )
*
*     %update = COND #( WHEN ls_dynamic_control-PoRelease = abap_false
*                      THEN if_abap_behv=>fc-o-enabled
*                      ELSE if_abap_behv=>fc-o-disabled
*
*
* )
* %action-porel = COND #( WHEN ls_dynamic_control-PoRelease = abap_false
*                      THEN if_abap_behv=>fc-o-enabled
*                      ELSE if_abap_behv=>fc-o-disabled
*
* ) ) ).

  ENDMETHOD.

  METHOD Static_ALL.

    SELECT FROM zab_po_header_mg FIELDS ebeln , po_release
    WHERE po_release = @abap_false
    INTO TABLE @DATA(lt_static_act).

    LOOP AT lt_static_act INTO DATA(ls_static_action).

      MODIFY ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1
      UPDATE FIELDS ( PoRelease )
      WITH VALUE #( (  Ebeln = ls_static_action-ebeln
                    PoRelease = abap_true
      ) ) .

      READ ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1
             ALL FIELDS WITH VALUE #( (  Ebeln = ls_static_action-Ebeln ) )
             RESULT DATA(lt_result).

      result = VALUE #( FOR ls_result IN lt_result
          (

            %param-Ebeln = ls_result-Ebeln
            %param-PoRelease = ls_result-PoRelease
          )
          ).
    ENDLOOP.

    INSERT VALUE #(

    %msg = new_message_with_text(
             severity = if_abap_behv_message=>severity-success
             text     = |{ lines( lt_static_act ) } Records has been upadted |
           )


    ) INTO TABLE reported-ZC_ZI_POHEADER_MANAGED1.




  ENDMETHOD.

  METHOD migo_status_update.
    READ ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1
     ALL FIELDS WITH VALUE #( FOR ls_key IN keys
     ( Ebeln = ls_key-Ebeln ) ) RESULT DATA(lt_migo_status).

    LOOP AT  lt_migo_status ASSIGNING FIELD-SYMBOL(<fs_migo>).
      IF <fs_migo>-PoRelease EQ abap_true.
        MODIFY ENTITY IN LOCAL MODE ZC_ZI_POHEADER_MANAGED1
        UPDATE FIELDS (  MigoStatus )
        WITH VALUE #( ( Ebeln = <fs_migo>-Ebeln
                        MigoStatus = 'GR has done'
        ) ).

      ENDIF.
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
