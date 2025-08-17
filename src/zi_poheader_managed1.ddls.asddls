@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO Header Interface CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_POHEADER_MANAGED1 as select from zab_po_head_mngd
{
    key ebeln as Ebeln,
    bukrs as Bukrs,
    supplier as Supplier,
    bsart as Bsart,
    lifnr as Lifnr,
    land1 as Land1,
    country_desc as CountryDesc,
    po_release as PoRelease,
    migo_status as MigoStatus,
    email as Email,
    lastdatetime as Lastdatetime
}
