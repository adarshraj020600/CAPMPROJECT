using { salesorderapp.db as db } from '../db/schema';
using {salesorderapp.reuse as reuse} from '../db/reuse';
// using {
//     Currency
// } from '@sap/cds/common';
 
service SalesOrderAppService {
    entity BPService as projection on db.master.businessparnters;
    // @readonly
    entity AddServices as projection on db.master.Addresses;
    entity ProdService as projection on db.master.Products;
 
    // @capabilities : {
    //   @Insrtrtrestrictions.Insertable : true,
    //   @Updatrestrictions.updatable : true,
    //   @Deletrestrictions.Deletable : false,
    //   @Readrestrictions.Readable : false
    // }
    entity EmpService as projection on db.master.Employees;
 
     entity SOService     as projection on db.transaction.SalesOrders
    {
        *,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'In Process'
            when 'C' then 'Completed'
            else 'Unknown'
        end as OST : String(15) @title : '{i18n>OVERALL_STATUS}',
        case LIFECYCLE_STATUS
            when 'N' then 'Not Paid'
            when 'P' then 'Paid'
            when 'C' then 'Completed'
            when 'D' then 'Delivered'
            else 'Unknown'
        end as LST : String(15) @title : '{i18n>LIFECYCLE_STATUS}',
        case OVERALL_STATUS
            when 'N' then 1
            when 'P' then 2
            when 'C' then 3
            else 0
        end as OSC : Integer,
        case LIFECYCLE_STATUS
            when 'N' then 1
            when 'P' then 2
            when 'C' then 3
            when 'D' then 1
            else 0
        end as LSC : Integer
    } actions {
        @cds.odata.bindingparameter.name : 'discount'
        @Common.SideEffects                      :{TargetProperties :[
            'discount/GROSS_AMOUNT',
            'discount/NET_AMOUNT',
            'discount/TAX_AMOUNT'
        ]
        }
        // Step - 1 : Declaration of instance bounded action
        action discountPrice();
    };
    entity SOItemService as projection on db.transaction.SalesItems;
    
      // Declaration of Custom Function
    function gethighestSalary() returns array of String;

    // Declaration of Custom Action
    action   createEmployee(
        ID : UUID,
        NAMEFIRST : reuse.Name,
        NAMELAST: reuse.Name,
        NAMEINITIAL : reuse.Name,
        NAMEMIDDLE : reuse.Name,
        GENDER : reuse.Gender,
        LANGUAGE : String(10),
        PHONE : reuse.PhoneNumber,
        EMAIL : reuse.Email,
        EMPLOYEEID : Integer,
        LOGINNAME : reuse.Name,
        CURRENCY : String,
        SALARY : reuse.AmountT,
        ACCOUNTNUMBER : String(16),
        BANKID : String(16),
        BANKNAME : String(255)
    ) returns array of String;
}