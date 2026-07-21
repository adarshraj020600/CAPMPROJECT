// namespace salesorderapp.db;
 
// //Sales Order,Sales Item,Business partner,product,business
// // Common Types and Aspects for reuse in other CDS files
// using {
//     // cuid,
//     // managed,
//     // temporal,
//     Language,
//     Currency
// } from '@sap/cds/common';
 
// // Custom Types and Aspects for reuse in other CDS files
// using {salesorderapp.reuse as reuse} from './reuse';

// context master {
//     entity businesspartners {
//         key NODE_KEY : reuse.identity;  //type is grtting used from reuse.cds file
//         BP_ROLE : String(2);
//         Email : reuse.email;
//         Mobile : reuse.phoneNumber;
//         fax : String(32);
//         WEB : String(255);
//         BP_ID : reuse.identity;
//         COMPANY_NAME : reuse.names;
//         ADDRESS : association to Addresses; 
//     }
//     entity Addresses : reuse.addressAspect {
//         key NODE_KEY     : reuse.identity;
//             ADDRESS_TYPE : String(44);
//             VAL_START    : Date;
//             VAL_END      : Date;
//             LATITUDE     : Decimal;
//             LONGITUDE    : Decimal;
//             // Unamanged Association between Addresses and Business Partners
//             // Foreign Key - Address
//             BP           : Association to one businesspartners
//                                on BP.ADDRESS = $self;
//     }
 
//     entity Products {
//         key NODE_KEY       : reuse.identity;
//             PRODUCT_ID     : String(30);
//             TYPE_CODE      : String(2);
//             CATEGORY       : String(32);
//             DESCRIPTION    : String(255);
//             TAX_TARIF_CODE : Integer;
//             MEASURE_UNIT   : String(2);
//             WEIGHT_MEASURE : Decimal(5, 2);
//             WEIGHT_UNIT    : String(2);
//             CURRENCY_CODE  : String(4);
//             PRICE          : Decimal(15, 2);
//             WIDTH          : Decimal(5, 2);
//             DEPTH          : Decimal(5, 2);
//             HEIGHT         : Decimal(5, 2);
//             DIM_UNIT       : String(2);
//             // Managed Association between Products and Business Partners
//             SUPPLIER       : Association to one businesspartners;
//     }
 
//     entity Employees {
//         key ID            : UUID;
//         NAMEFIRST : reuse.names;
//         NAMELAST : reuse.names;
//         NAMEINITIAL : reuse.names;
//         NAMEMIDDLE : reuse.names;
//         GENDER : reuse.gender;
//         // LANGUAGE : Language;
//         LANGUAGE  : String(10);
//         PHONE : reuse.phoneNumber;
//         EMAIL : reuse.email;
//         EMPLOYEEID : Integer;
//         LOGINNAME : reuse.names;
//         CURRENCY : Currency;
//         SALARY : reuse.Amount;
//         ACCOUNTNUMBER : String(16);
//         BANKID : String(16);
//         BANKNAME : String(255);
//     }
// }

// context transaction {
//     entity SalesOrders : reuse.amountAspect {
//        key NODE_KEY         : reuse.identity;
//            SO_ID            : String(40);
//            PARTNER          : Association to one master.businesspartners;
//            LIFECYCLE_STATUS : String(2);
//            OVERALL_STATUS   : String(2);
//            // Unmanaged Association betwen Sales Orders and Sales Items
//            Items            : Association to many SalesItems
//                                   on Items.PARENT = $self;
//   }
 
//   entity SalesItems : reuse.amountAspect {
//        key NODE_KEY     : reuse.identity;
//            PO_ITEMS_POS : Integer;
//            PRODUCT      : Association to one master.Products;
//            PARENT       : Association to one SalesOrders;
//   }
// }
namespace salesorderapp.db;
 
// Sales Orders, Sales Items, Business Partner, Product, Address...etc
 
// Common Types and Aspects for reuse in other CDS files
using {
    // cuid,
    // managed,
    // temporal,
    // Language,
    Currency
} from '@sap/cds/common';
 
// Custom Types and Aspects for reuse in other CDS files
using {salesorderapp.reuse as reuse} from './reuse';
 
context master {
    entity businessparnters {
        key NODE_KEY     : reuse.identity @(title: '{i18n>NODE_KEY}');
            BP_ROLE      : String(2)    @(title: '{i18n>BP_ROLE}');
            EMAIL        : reuse.Email  @(title: '{i18n>EMAIL}');
            MOBILE       : reuse.PhoneNumber    @(title: '{i18n>MOBILE}');
            FAX          : String(32)   @(title: '{i18n>FAX}');
            WEB          : String(255)  @(title: '{i18n>WEB}');
            BP_ID        : reuse.identity   @(title: '{i18n>BP_ID}');
            COMPANY_NAME : reuse.Name @(title: '{i18n>COMPANY_NAME}');
            // Foreign Key - Business Partners
            ADDRESS      : Association to Addresses;
    }
 
    entity Addresses : reuse.Address {
        key NODE_KEY     : reuse.identity @(title: '{i18n>NODE_KEY}');
            ADDRESS_TYPE : String(44) @(title: '{i18n>ADDRESS_TYPE}');
            VAL_START    : Date @(title: '{i18n>VAL_START}');
            VAL_END      : Date @(title: '{i18n>VAL_END}');
            LATITUDE     : Decimal @(title: '{i18n>LATITUDE}');
            LONGITUDE    : Decimal @(title: '{i18n>LONGITUDE}');
            // Unamanged Association between Addresses and Business Partners
            // Foreign Key - Address
            BP           : Association to one businessparnters
                               on BP.ADDRESS = $self;
    }
 
    entity Products {
        key NODE_KEY       : reuse.identity @(title: '{i18n>NODE_KEY}');
            PRODUCT_ID     : String(30) @(title: '{i18n>PRODUCT_ID}');
            TYPE_CODE      : String(2) @(title: '{i18n>TYPE_CODE}');
            CATEGORY       : String(32) @(title: '{i18n>CATEGORY}');
            DESCRIPTION    : String(255) @(title: '{i18n>DESCRIPTION}');
            TAX_TARIF_CODE : Integer @(title: '{i18n>TAX_TARIF_CODE}');
            MEASURE_UNIT   : String(2) @(title: '{i18n>MEASURE_UNIT}');
            WEIGHT_MEASURE : Decimal(5, 2) @(title: '{i18n>WEIGHT_MEASURE}');
            WEIGHT_UNIT    : String(2) @(title: '{i18n>WEIGHT_UNIT}');
            CURRENCY_CODE  : String(4) @(title: '{i18n>CURRENCY_CODE}');
            PRICE          : Decimal(15, 2) @(title: '{i18n>PRICE}');
            WIDTH          : Decimal(5, 2) @(title: '{i18n>WIDTH}');
            DEPTH          : Decimal(5, 2) @(title: '{i18n>DEPTH}');
            HEIGHT         : Decimal(5, 2) @(title: '{i18n>HEIGHT}');
            DIM_UNIT       : String(2) @(title: '{i18n>DIM_UNIT}');
            // Managed Association between Products and Business Partners
            SUPPLIER       : Association to one businessparnters;
    }
 
    entity Employees {
        key ID            : UUID;
            NAMEFIRST     : reuse.Name;
            NAMELAST      : reuse.Name;
            NAMEINITIAL   : reuse.Name;
            NAMEMIDDLE    : reuse.Name;
            GENDER        : reuse.Gender;
            LANGUAGE      : String(10);
            PHONE         : reuse.PhoneNumber;
            EMAIL         : reuse.Email;
            EMPLOYEEID    : Integer;
            LOGINNAME     : reuse.Name;
            CURRENCY      : Currency;
            SALARY        : reuse.AmountT;
            ACCOUNTNUMBER : String(16);
            BANKID        : String(16);
            BANKNAME      : String(255);
    }
}
 
 
context transaction {
    entity SalesOrders : reuse.Amount {
        key NODE_KEY         : reuse.identity @(title: '{i18n>NODE_KEY}');
            SO_ID            : String(40) @(title: '{i18n>SO_ID}');
            PARTNER          : Association to one master.businessparnters;
            LIFECYCLE_STATUS : String(2) @(title: '{i18n>LIFECYCLE_STATUS}');
            OVERALL_STATUS   : String(2) @(title: '{i18n>OVERALL_STATUS}');
            // Unmanaged Association betwen Sales Orders and Sales Items
            Items            : Association to many SalesItems
                                   on Items.PARENT = $self;
    }
 
    entity SalesItems : reuse.Amount {
        key NODE_KEY     : reuse.identity @(title: '{i18n>NODE_KEY}');
            PO_ITEMS_POS : Integer @(title: '{i18n>PO_ITEMS_POS}');
            PRODUCT      : Association to one master.Products;
            PARENT       : Association to one SalesOrders;
    }
}
 