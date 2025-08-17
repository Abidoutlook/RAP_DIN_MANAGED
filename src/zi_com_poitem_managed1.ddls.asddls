@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composite CDS view for PO Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_COM_POITEM_MANAGED1 as select from ZI_POitem_MANAGED1
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
    @semantics.systemDateTime.localInstanceLastChangedAt: true
    Lastdatechanged
}
