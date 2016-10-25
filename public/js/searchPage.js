
$(document).ready(function() {
	document.getElementById("submit-button").addEventListener("click", showTable);
	$("#table-view").hide();
	//document.getElementById("table-view").style.visibility="hidden";
});

function showTable() {
	//document.getElementById("table-view").style.visibility="visible";
	$("#table-view").show(1000);
}

var dataSet = [
    [ "Gateway Homeless Services", "15", "1000 N 19th Street", "24-hour emergency housing", "(314) 213-1515", "Gateway Homeless Services Website", "1.8 miles"],
    [ "St. Patrick Center",	"0",	"800 N Tucker Boulevard",	"-Emergency Shelter","(314) 802-0700",	"St. Patrick Website",	"2.2 miles"],
    [ "Sunshine Ministries", "3",	"1520 N 13th Street",	"-Emergency Shelter -Men Only",	"(314) 231-8209",	"Sunshine Ministries Website",	"2.9 miles"]
];

$(document).ready(function() 
    { 
        //$("#myTable").DataTable();
        $('#myTable').DataTable( {
                data: dataSet,
                columns: [
                    { title: "Shelter Name" },
                    { title: "Bed Availability" },
                    { title: "Shelter Location" },
                    { title: "Shelter Type(s)" },
                    { title: "Shelter Phone" },
                    { title: "Shelter Website" },
                    { title: "Current Distance From Shelter" },
                ]
            } ); 
        
    } 
); 
