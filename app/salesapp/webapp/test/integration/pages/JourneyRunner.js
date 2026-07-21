sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"salesapp/test/integration/pages/SOServiceList.gen",
	"salesapp/test/integration/pages/SOServiceObjectPage.gen",
	"salesapp/test/integration/pages/SOItemServiceObjectPage.gen"
], function (JourneyRunner, SOServiceListGenerated, SOServiceObjectPageGenerated, SOItemServiceObjectPageGenerated) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('salesapp') + '/test/flp.html#app-preview',
        pages: {
			onTheSOServiceListGenerated: SOServiceListGenerated,
			onTheSOServiceObjectPageGenerated: SOServiceObjectPageGenerated,
			onTheSOItemServiceObjectPageGenerated: SOItemServiceObjectPageGenerated
        },
        async: true
    });

    return runner;
});

