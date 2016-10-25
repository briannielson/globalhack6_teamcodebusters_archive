var dataSet = [
    [ "Male Youth", "50", "24"],
    [ "Female Youth", "30","34"],
    [ "Male", "40", "34" ],
    [ "Female", "60", "45"],
    [ "Family", "20", "13"]
];
var homeless_types = ['Male Youth', 'Female Youth', 'Male Adult', 'Female Adult', 'Family'];

function toHTypes(val) {
  var result = '';
  var vals = val.split(',');
  for (var val of vals) {
    result += ',' + homeless_types[parseInt(val) - 1];
  }
  return result.slice(1);
}

$(document).ready(function() 
    { 
        //$("#myTable").DataTable();
        $.get("/shelter/status.json", function (data) {

        var dataset = [];
        for (var row of data.beds) {
          dataset.push([toHTypes(row.bed_types), row.available, row.total]);
        }
        $('#myTable').DataTable( {
                data: dataset,
                columns: [
                    { title: "Type" },
                    { title: "Number Available" },
                    { title: "Number Existing" },
                ]
            } ); 
    });   

     $('.map').each(function() {
            var myLink = this.href;
            this.href = myLink.replace(" ", "+");
           
        });
        $('.time').each(function() {
            var hour = parseInt($(this).text());
            var isAm = hour < 12;

            if (hour == 0)
                hour = 12;
            if(hour > 12) {
                hour -=12;
            }
            if (isAm)
                $(this).text(hour + " am");
            else
                $(this).text(hour + " pm");
        });

        $('.phone-number').each(function() {
            //9892345463
            //0123456789
            var number = $(this).text();
            //(989) 234-5463
            $(this).text("(" + number.slice(0, 3) + ") " + number.slice(3, 6) + "-" + number.slice(6));
        });
        
    } 
); 
