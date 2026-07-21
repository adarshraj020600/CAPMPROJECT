module.exports = cds.service.impl( async function() {
    // There are three types of generic handlers: before, after and on.
    // this.before() : It is used to intercept the request before it is processed by the service handler. It is used in pre-checks and validations.
    // this.after() : It is used to intercept the request after it is processed by the service handler. It is used in post-processing and data manipulation.
    // this.on() : It is used to define custom actions and functions for the service.
 
    // Step - 1 : Create a reference to the entity defined in the service.cds file. This is done using
    // the cds.entities object,which contains all the entities defined in the service.cds file.
    let { EmpService , ProdService , SOService } = this.entities;
 
    this.before('UPDATE','EmpService', (request, response) => {
        console.log("Salary to be updated : ", request.data.SALARY);
 
        if (request.data.SALARY > 100000) {
            request.error(400, "Please get the approval from your line manager.");
        }
    })

    this.before('INSERT', 'EmpService', (request, response) => {
        console.log("Salary to be inserted : ", request.data.SALARY);
        console.log("Currency to be inserted : ", request.data.CURRENCY_code);
 
        if(request.data.SALARY > 100000 && request.data.CURRENCY_code === 'INR') {
            request.error(400, "Please get the approval from your line manager as your salary is more than 100000 INR.");
        } else if(request.data.SALARY > 10000 && request.data.CURRENCY_code === 'USD') {
            request.error(400, "Please get the approval from your line manager as your salary is more than 10000 USD.");
        }
    })
    this.on('gethighestSalary', async (request, response) => {
        try {
            // Step-3 : Create an object for the transaction
            const tx = cds.tx(request);
 
            // Step-4 : Get salary of an employee using Transaction object
            const response = await tx.read(EmpService).columns('SALARY').orderBy({
                SALARY: 'desc'
            }).limit(10);
 
            // Step-5 : Return the response
            return response;
        } catch (error) {
            return "Error : " + error;
        }
    })
    this.on('createEmployee', async (request, response) => {
          try {
        // Custom business logic to create an employee
        // Step-2 : Get the data from the request object
        let dataset = request.data;
 
        // Step-3 : Create an object for the transaction
        let tx = cds.tx(request);
 
        // Step-4 : Insert the data into the database using Transaction object
        let returnData = await tx.run([
            INSERT.into(EmpService).entries(dataset)
        ]).then((resolve, reject)=> {
            if(typeof(resolve) !== 'undefined') {
                return request.data;
            } else {
                request.error(500, "Error in creating employee");
            }
        }).catch(error => {
            request.error(500, "Error : " + error);
        })
        } catch (error) {
            request.error(500, "Error : " + error);
        }
    
        })
        this.on('discountPrice', async(request, response)=>{
        try {
            const ID = request.params[0];
 
            const tx = cds.tx(request);
 
            await tx.update(SOService).with({
                GROSS_AMOUNT : {
                    '-=' : 1000
                },
                NET_AMOUNT : {
                    '-=' : 800
                },
                TAX_AMOUNT : {
                    '-=' : 200
                }
            }).where(ID);
 
            return "Discount of 1000 applied successfully for the Sales Order with ID : " + ID;
        } catch (error) {
            return "Error : " + error;
        }
    })

})