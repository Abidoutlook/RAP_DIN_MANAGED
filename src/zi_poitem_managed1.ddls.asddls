@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface CDS View for PO Item'
@Metadata.ignorePropagatedAnnotations: false
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_POitem_MANAGED1 as select from z323_poitem_mngd
{
    key ebeln as Ebeln,
    key ebelp as Ebelp,
    matnr as Matnr,
    werks as Werks,
    lgort as Lgort,
    menge as Menge,
    meins as Meins,
    netpr as Netpr,
    waers as Waers,
    lastdatechanged as Lastdatechanged
}
