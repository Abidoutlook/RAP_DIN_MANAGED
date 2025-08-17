@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO header Composite CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_COM_POHEADER_MANAGED1 as select from ZI_POHEADER_MANAGED1
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
    Lastdatetime
}
