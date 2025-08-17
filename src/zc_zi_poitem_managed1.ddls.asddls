@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite CDS view for PO Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_ZI_POITEM_MANAGED1
  as select from ZI_COM_POITEM_MANAGED1
  association to parent ZC_ZI_POHEADER_MANAGED1 as _head on $projection.Ebeln = _head.Ebeln
{
  key Ebeln,
  key Ebelp,
      Matnr,
      Werks,
      Lgort,
      @Semantics.quantity.unitOfMeasure: 'Meins'
      Menge,
      Meins,
      @Semantics.amount.currencyCode: 'Waers'
      Netpr,
      Waers,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Lastdatechanged,
      _head // Make association public
}
