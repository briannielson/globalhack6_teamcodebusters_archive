var homeless_types = ['Male Youth', 'Female Youth', 'Male Adult', 'Female Adult', 'Family'];

function toHTypes(val) {
  var result = '';
  var vals = val.split(',');
  for (var val of vals) {
    result += ',' + homeless_types[parseInt(val) - 1];
  }
  return result.slice(1);
}

$(document).ready(function() {
	$('#genID').click(function(e) {
		e.preventDefault();
		if ($("#clienttype").val() == "" || $("#beds").val() <= 0) {
			window.alert("You have to have a client type and # of beds to create a user.");
		} else {
			$.get("/user/add?type=" + $("#clienttype").val() + "&size=" + $("#beds").val(), function (data) {
				$('#email').val(data.uuid);
			});
		}
	});

	$('#checkin').click(function(e) {
		e.preventDefault();
		if ($("#clienttype").val() == "" || $("#beds").val() <= 0 || $("#clienttype").val() == "") {
			window.alert("You have to have a client type, # of beds, and User ID to check a user in.");
		} else {
			$.get("/checkin?uuid=" + $("#email").val() + "&type=" + $("#clienttype").val() + "&size=" + $("#beds").val(), function (data) {
				location.reload();
			});
		}
	});
	$('#checkout').click(function(e) {
		e.preventDefault();

	});
	$('#email').on("change", function() {
		$.get("/user/get?uuid=" + $("#email").val(), function (data) {
				//Shadowbox checked in
				$("#clienttype").val(data.user[0].type);
				$("#beds").val(data.user[0].size);
			});
	});

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
}) 
