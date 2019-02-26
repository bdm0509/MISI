var ready = function() {
	init_navigation_menu();
	init_jquery_ui_controls();
  init_sitewide_bindings();
  
  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    }
  });
};

$(document).ready(ready);
$(document).on('page:load', ready);

///////
// 
// This function initializes the navigation menu
//
function init_navigation_menu() {
  $("#navigation_menu").menu();
}

///////
// 
// This function initializes all the stock jQuery and jQuery UI controls so
//   that any element on the page can turn itself into a control
//
function init_jquery_ui_controls() {  
  $("input[type=submit]").button();
  $("input:reset").button();
  $("a.button").button();
  $("a.button.wrench").button({
    icons: { primary: "ui-icon-wrench" },
    text: false
  });
  $("a.button.delete").button({
    icons: { primary: "ui-icon-close" },
    text: false
  });

  // $(".datepicker").datepicker();  
  // $(".timepicker").datetimepicker();
}

////////
//
// This function sets up bindings that need to be in place.
//   This doesn't assume a particular path to a page, so is
//   where potentially bookmarked-page logic might need to do.
//
function init_sitewide_bindings() {
  $(document).on('change', '#maintenance_order_assured_id', function() {
    assured_id = $('#maintenance_order_assured_id').val();
    if (assured_id > 0) {
      $.ajax({
        url: '/assureds/' + assured_id,
        method: 'GET',
        dataType: 'script'
      });
    }
  });
  
  $(document).on('change', '#maintenance_order_maintenance_fund_id', function() {
    hoa_id = $('#maintenance_order_maintenance_fund_id').val();
    if (hoa_id > 0) {
      $.ajax({
        url: '/maintenance_funds/' + hoa_id,
        method: 'GET',
        dataType: 'script'
      });
    }
  });
}

///////////////////////////////////////////////////////////////
// 
// Core functionality shared across MISI
//
///////////////////////////////////////////////////////////////
function misi_alert(id, dialog_height, dialog_width) {
  dialog_height = typeof(dialog_height) != "undefined" ? dialog_height : 140;
  dialog_width  = typeof(dialog_width)  != "undefined" ? dialog_width  : 250;
  
  
  $(id).dialog({
    autoOpen: false,
    height:   dialog_height,
    width:    dialog_width,
    modal:    true,
    buttons: {
      Ok: function() {
        $(this).dialog("close")
      }
    }
  });
}

function misi_error(error_message) {
  $("#error_message").html(error_message);
  $("#error-dialog").dialog("open");
}

function misi_info_message(info_message) {
  $("#information_message").html(info_message);
  $("#information-dialog").dialog("open");
}

///////////////////////////////////////////////////////////////
// 
// Assured functionality and support JavaScript
//
///////////////////////////////////////////////////////////////
function assured_init_page(num_assureds) {
  misi_alert("#contact_information", 250, 400);
  $('#create_new_assured').button();
  
  if (num_assureds > 0) {
    $('#assureds_table').dataTable({
      "bJQueryUI":      true,
      "bAutoWidth":     false,
      "bPaginate":      true,
      "iDisplayLength": 25,
      "aLengthMenu":    [[25, 50, 100, -1], [25, 50, 100, "All"]],
      "aoColumns": [
        { "bSearchable": true, "sWidth": "175px" },
        { "bSearchable": true, "sWidth": "160px" },
        { "bSearchable": true, "sWidth": "80px" },
        { "bSearchable": true, "sWidth": "40px" },
        { "bSearchable": true, "sWidth": "40px" },
        { "bSearchable": true, "sWidth": "40px" },
        { "bSearchable": true, "sWidth": "100px" },
        { "bSearchable": false, "bSortable": false, "sWidth": "20px" }
      ]
    });
  }
}

function assured_contact_info(assured_id) {
  $("#contact_information-title").html($("tr#assured-" + assured_id + " td.assured_title").html());
  $("#contact_information-contact").html($("tr#assured-" + assured_id + " input.assured_contact_name").val());
  $("#contact_information-phone").html($("tr#assured-" + assured_id + " input.assured_contact_phone").val());
  
  $("#contact_information").dialog("open");
}

function highlight_assured(assured_id) {
  $("tr#assured-" + assured_id).effect("highlight", {}, 3000);
}

///////////////////////////////////////////////////////////////
// 
// Fee Collection Types and support JavaScript
//
///////////////////////////////////////////////////////////////
function fee_collection_type_init_page(num_fee_collection_types) {
  $('#create_new_fee_collection_type').button();
  
  if (num_fee_collection_types > 0) {
    $('#fee_collection_types_table').dataTable({
      "bJQueryUI":      true,
      "bAutoWidth":     false,
      "bPaginate":      true,
      "iDisplayLength": -1,
      "aLengthMenu":    [[10, 20, -1], [10, 20, "All"]],
      "aoColumns": [
        { "bSearchable": true, "sWidth": "200px" },
        { "bSearchable": true, "sWidth": "160px" },
        { "bSearchable": false, "bSortable": false, "sWidth": "20px" }
      ]
    });
  }
}

function highlight_fee_collection_type(fee_collection_type_id) {
  $("tr#fee_collection_type-" + fee_collection_type_id).effect("highlight", {}, 3000);
}

///////////////////////////////////////////////////////////////
// 
// Maintenance Order functionality and support JavaScript
//
///////////////////////////////////////////////////////////////
function maintenance_order_init_page(num_maintenance_orders) {
  $('#create_new_maintenance_order').button();
  $('#show_archived_orders').button();
  
  if (num_maintenance_orders > 0) {
    $('#maintenance_orders_table').dataTable({
      "bJQueryUI":      true,
      "bAutoWidth":     false,
      // "bPaginate":      true,
      "iDisplayLength": 25,
      "aLengthMenu":    [[25, 50, 100, -1], [25, 50, 100, "All"]],
			"bProcessing":     true,
			"bServerSide":    true,
			"sAjaxSource":    $('#maintenance_orders_table').data('source'),
			"fnDrawCallback": function(oSettings, json) {
			  $("a.button.delete").button({
			    icons: { primary: "ui-icon-close" },
			    text: false
			  });
			},
      "aoColumns": [
        { "bSearchable": true, "sWidth": "80px" },
        { "bSearchable": true, "sWidth": "80px" },
        { "bSearchable": true, "sWidth": "80px" },
        { "bSearchable": true, "sWidth": "180px" },
        { "bSearchable": true, "sWidth": "80px" },
        { "bSearchable": true, "sWidth": "250px" },
        { "bSearchable": false, "bSortable": false, "sWidth": "20px" }
      ]
    });
  }
}

function highlight_maintenance_order(maintenance_order_id) {
  $("tr#maintenance_order-" + maintenance_order_id).effect("highlight", {}, 3000);
}

function print_maintenance_order(print_path) {
  var theForm = $("#maintenance_order").find("form:first");
  var valuesToSubmit = theForm.serialize();
  
  theForm.target = '_print';
  theForm.attr('action', print_path);
  theForm.submit();
  
  //$.ajax({
  //  url: print_path,
  //  data: valuesToSubmit,
  //  type: "POST"
  // });
}

///////////////////////////////////////////////////////////////
// 
// Tax Certificate functionality and support JavaScript
//
///////////////////////////////////////////////////////////////
function tax_certificate_init_page(num_tax_certificates) {
  $('#create_new_tax_certificate').button();
  
  if (num_tax_certificates > 0) {
    $('#tax_certificates_table').dataTable({
      "bJQueryUI":      true,
      "bAutoWidth":     false,
      "iDisplayLength": 25,
      "aLengthMenu":    [[25, 50, 100, -1], [25, 50, 100, "All"]],
			"bProcessing":     true,
			"bServerSide":    true,
			"sAjaxSource":    $('#tax_certificates_table').data('source'),
			"fnDrawCallback": function(oSettings, json) {
			  $("a.button.delete").button({
			    icons: { primary: "ui-icon-close" },
			    text: false
			  });
			},
      "aoColumns": [
        { "bSearchable": true, "sWidth": "80px" },
        { "bSearchable": true, "sWidth": "80px" },
        { "bSearchable": true, "sWidth": "80px" },
        { "bSearchable": true, "sWidth": "180px" },
        { "bSearchable": true, "sWidth": "80px" },
        { "bSearchable": true, "sWidth": "250px" },
        { "bSearchable": false, "bSortable": false, "sWidth": "20px" }
      ]
    });
  }
}

function highlight_maintenance_order(maintenance_order_id) {
  $("tr#maintenance_order-" + maintenance_order_id).effect("highlight", {}, 3000);
}

function print_maintenance_order(print_path) {
  var theForm = $("#maintenance_order").find("form:first");
  var valuesToSubmit = theForm.serialize();
  
  theForm.target = '_print';
  theForm.attr('action', print_path);
  theForm.submit();
  
  //$.ajax({
  //  url: print_path,
  //  data: valuesToSubmit,
  //  type: "POST"
  // });
}

///////////////////////////////////////////////////////////////
// 
// Maintenance Fund functionality and support JavaScript
//
///////////////////////////////////////////////////////////////
function maintenance_fund_init_page(num_maintenance_funds) {
  misi_alert("#contact_information", 250, 400);
  $('#create_new_maintenance_fund').button();
  $('#print_maintenance_funds').button();
	
  if (num_maintenance_funds > 0) {
    $('#maintenance_funds_table').dataTable({
      "bJQueryUI":      true,
      "bAutoWidth":     false,
      "iDisplayLength": 25,
      "aLengthMenu":    [[25, 50, 100, -1], [25, 50, 100, "All"]],
			"bProcessing":     true,
			"bServerSide":    true,
			"sAjaxSource":    $('#maintenance_funds_table').data('source'),
			"fnDrawCallback": function(oSettings, json) {
			  $("a.button.delete").button({
			    icons: { primary: "ui-icon-close" },
			    text: false
			  });
			},
      "aoColumns": [
        { "sWidth": "175px" },
        { "sWidth": "160px" },
        { "sWidth": "80px" },
        { "sWidth": "40px" },
        { "sWidth": "40px" },
        { "sWidth": "40px" },
        { "bSortable": false, "sWidth": "100px" },
        { "bSortable": false, "sWidth": "20px" }
      ]
			
    });
  }
  
  $("#print_confirm").dialog({
		resizable: false,
		height: 250,
		width: 450,
		modal: true,
		autoOpen: false
	});
	
/*
  $('#print_maintenance_funds').click(function(e) {
    e.preventDefault();
    targetURL = $(this).attr("href");
    
    $("#print_confirm").dialog({
      buttons: {
  			"Print HOA Listings": function() {
  			  window.location.href = targetURL + "?show_additional_contact_information=" + $("#show_additional_contact_information").is(":checked");
  			  $(this).dialog("close");
  			},
  			Cancel: function() {
  				$(this).dialog("close");
  			}
  		}
    });
    
    $("#print_confirm").dialog("open");
  });
	*/
}

function maintenance_fund_contact_info(name, contact, phone) {
  $("#contact_information-name").html(name);
  $("#contact_information-contact").html(contact);
  $("#contact_information-phone").html(phone);
  
  $("#contact_information").dialog("open");
}

function maintenance_fund_fees_init_page(num_maintenance_fund_fees) {
  $("#maintenance_fund_fee_information").dialog({
    autoOpen: false,
    height:   240,
    width:    400,
    modal:    true,
    buttons: {
      "Close": function() {
        $(this).dialog("close");
      },
      "Update this fee listing": function() {
        var valuesToSubmit = $("#fee_listing_form").serialize();
				var id = $('#maintenance_fund_fee_id').val();
				var isNew = id == null || id == '';
				
        $.ajax({
          method: isNew ? 'POST' : 'PUT',
          url: "/maintenance_fund_fees/" + id,
          data: valuesToSubmit,
          dataType: 'script'
        });
        $(this).dialog("close");
      }
    }
  });
  
  $('#create_new_maintenance_fund_fee').button();

  maintenance_fund_fees_table_init(num_maintenance_fund_fees);
}

function maintenance_fund_fees_table_init(num_maintenance_fund_fees) {
  if (num_maintenance_fund_fees > 0) { 
    $('#maintenance_fund_fees_table').dataTable({
      "bJQueryUI":      true,
      "bAutoWidth":     false,
      "iDisplayLength": 25,
      "aLengthMenu":    [[25, 50, 100, -1], [25, 50, 100, "All"]],
      "aoColumns": [
        { "sWidth": "125px" },
        { "sWidth": "300px" },
        { "sWidth": "200px" },
      ]
			
    });
  }
}

function check_for_empty_data() {
  // Check name field and pass control to validation if not present
  if (!$("#maintenance_fund_name").val()) {
    // Let processing by validator take over
    $("#maintenance_fund_form").submit();
    return;
  }
  
  // Not really needed but just for sanity's sake...
  empty_fields = false;
  
  // Check for empty fields
  empty_fields = (!$("#maintenance_fund_collector").val() ||
                  !$("#maintenance_fund_street").val() ||
                  !$("#maintenance_fund_city").val() ||
                  !$("#maintenance_fund_zip").val() ||
                  !$("#maintenance_fund_phone").val());
  
  if (empty_fields) {
    $("#dialog-confirm").dialog({
      resizable: false,
    	height: 180,
    	width: 425,
    	modal: true,
    	buttons: {
    	  "Create this HOA Anyway": function() {
          $("#maintenance_fund_form").submit();
          $(this).dialog("close");
    	  },
    		"Cancel and return to editing": function() {
    			$(this).dialog("close");
    		}
    	}
    });
  } else {
    $("#maintenance_fund_form").submit();
  }
}

function add_maintenance_fund_fee() {
  $("#maintenance_fund_fee_year").val("");
  $("#maintenance_fund_fee_amount").val("");
  $("#maintenance_fund_fee_fee_collection_type_id").val("");
  $("#maintenance_fund_fee_id").val("");
  
  $("#maintenance_fund_fee_information").dialog("open");
}

function highlight_maintenance_fund(maintenance_fund_id) {
  $("tr#maintenance_fund-" + maintenance_fund_id).effect("highlight", {}, 3000);
}

function highlight_maintenance_fund_fee(maintenance_fund_fee_id) {
  $("tr#maintenance_fund_fee-" + maintenance_fund_fee_id).effect("highlight", {}, 3000);
}

function maintenance_fund_fee_info(maintenance_fund_fee_id) {
  $("#maintenance_fund_fee_id").val(maintenance_fund_fee_id);
  $("#maintenance_fund_fee_year").val($("tr#maintenance_fund_fee-" + maintenance_fund_fee_id + " td.maintenance_fund_fee_year a").html());
  
  $("#maintenance_fund_fee_information-year").html($("tr#maintenance_fund_fee-" + maintenance_fund_fee_id + " td.maintenance_fund_fee_year a").html());
  $("#maintenance_fund_fee_amount").val($("tr#maintenance_fund_fee-" + maintenance_fund_fee_id + " td.maintenance_fund_fee_amount").html());
  $("#maintenance_fund_fee_fee_collection_type_id").val($("tr#maintenance_fund_fee-" + maintenance_fund_fee_id + " td input.maintenance_fund_fee_collected_id").val());
  
  $("#maintenance_fund_fee_information").dialog("open");
}