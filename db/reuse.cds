// namespace salesorderapp.reuse;

// using { Currency as CURRENCY_CODE } from '@sap/cds/common';

// type identity : String(32);
// type phoneNumber : String(32);
// type names : String(64);
// type postalcode : String(16);
// type email : String(255);

// //Enumerator

// type gender : String(16) enum {
//     Male = 'M';
//     Female = 'F';
//     Undisclosed = 'U';
// }

// //Custom type 
// type Amount: Decimal(10, 2) @(
//     sap.unit: 'CURRENCY_CODE',
//     semantics.amount.currency: 'CURRENCY_CODE'
// );

// //Resusable aspects- group fo fields similar like structure
 
// aspect amountAspect {
//     Gross_Amount: Amount;
//     Net_Amount: Amount;
//     Currency: CURRENCY_CODE;
// }
// //resusable aspects- group of fields similar like structuture in ABAP
// aspect addressAspect {
//      STREET : String(255);
//   POSTAL : postalcode;
//   CITY : names;
//   COUNTY : names;
//   BUILDING : names;
// }
namespace salesorderapp.reuse;
 
// Common Types and Aspects for reuse in other CDS files
using { Currency  } from '@sap/cds/common';
 
// Custom Types
type identity : String(32);
type PhoneNumber : String(32);
type Name : String(255);
type PostalCode : String(16);
type Email : String(255);
 
 
// Enumerator
type Gender : String(1) enum {
    Male = 'M';
    Female = 'F';
    Undisclosed = 'U';
}
 
// Custom Type
type AmountT : Decimal(10, 2) @(
    Semantics.amount.currencyCode : 'CURRENCY_CODE',
    sap.unit : 'CURRENCY_CODE'
);
 
 
// Reusable Aspects - Group of Fields similar like a structure in ABAP
aspect Amount : {
    GROSS_AMOUNT : AmountT @(title: '{i18n>GROSS_AMOUT}');
    NET_AMOUNT : AmountT  @(title: '{i18n>NET_AMOUNT}');
    TAX_AMOUNT : AmountT  @(title: '{i18n>TAX_AMOUNT}');
    CURRENCY : Currency  @(title: '{i18n>CURRENCY_CODE}');
}
 
// Reusable Aspects - Group of Fields similar like a structure in ABAP for Address
aspect Address {
    STREET : String(255) @(title: '{i18n>STREET}');
    POSTAL : PostalCode @(title: '{i18n>POSTAL}');
    CITY : Name @(title: '{i18n>CITY}');
    COUNTY : Name @(title: '{i18n>COUNTRY}');
    BUILDING : Name @(title: '{i18n>BUILDING}');
}