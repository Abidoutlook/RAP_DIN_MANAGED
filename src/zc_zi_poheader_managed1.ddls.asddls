@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite CDS view for PO Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_ZI_POHEADER_MANAGED1
  as select from ZI_COM_POHEADER_MANAGED1
  composition [1..*] of ZC_ZI_POITEM_MANAGED1 as _item
{
  key Ebeln,
      Bukrs,
      Supplier,
      Bsart,
      Lifnr,
      Land1,
      CountryDesc,
      PoRelease,
      MigoStatus,
      Email,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true  // This annotation is used to allow the field to be used as ETAG in behviour definition
      Lastdatetime,
      cast('3' as abap.char(1)) as po_release,  // Added this extra field later in consumption view only to use as Criticality option in Action button for enabling color to button.
      cast('1' as abap.char(1)) as noporelease, // Added this extra field later in consumption view only to use as Criticality option in Action button for enabling color to button.
      _item // Make association public
}
