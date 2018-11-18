module ApplicationHelper
<<<<<<< HEAD
  
  # Returns the full title for an HTML page
  def full_title(page_title = '')
    base_title = "MISI"
    if page_title.empty?
      base_title
    else
      page_title + " :: " + base_title
    end
  end
  
  US_STATES = [
    ['Alaska', 'AK'],
    ['Alabama', 'AL'],
    ['Arizona', 'AZ'],
    ['Arkansas', 'AR'],
    ['California', 'CA'],
    ['Colorado', 'CO'],
    ['Connecticut', 'CT'],
    ['Delaware', 'DE'],
    ['District of Columbia', 'DC'],
    ['Florida', 'FL'],
    ['Georgia', 'GA'],
    ['Hawaii', 'HI'],
    ['Idaho', 'ID'],
    ['Illinois', 'IL'],
    ['Indiana', 'IN'],
    ['Iowa', 'IA'],
    ['Kansas', 'KS'],
    ['Kentucky', 'KY'],
    ['Lousiana', 'LA'],
    ['Maine', 'ME'],
    ['Maryland', 'MD'],
    ['Massachusetts', 'MA'],
    ['Michigan', 'MI'],
    ['Minnesota', 'MN'],
    ['Mississippi', 'MS'],
    ['Missouri', 'MO'],
    ['Montana', 'MT'],
    ['Nebraska', 'NE'],
    ['Nevada', 'NV'],
    ['New Hampshire', 'NH'],
    ['New Jersey', 'NJ'],
    ['New Mexico', 'NM'],
    ['New York', 'NY'],
    ['North Carolina', 'NC'],
    ['North Dakota', 'ND'],
    ['Ohio', 'OH'],
    ['Oklahoma', 'OK'],
    ['Oregon', 'OR'],
    ['Pennsylvania', 'PA'],
    ['Rhode Island', 'RI'],
    ['South Carolina', 'SC'],
    ['South Dakota', 'SD'],
    ['Tennessee', 'TN'],
    ['Texas', 'TX'],
    ['Utah', 'UT'],
    ['Virginia', 'VA'],
    ['Vermont', 'VT'],
    ['Washington', 'WA'],
    ['Wisconsin', 'WI'],
    ['West Virigina', 'WV'],
    ['Wyoming', 'WY']
  ]
  
=======
  def datatable(columns, opts={})
    sort_by = opts[:sort_by] || nil
    additional_data = opts[:additional_data] || {}
    search = opts[:search].present? ? opts[:search].to_s : "true"
    search_label = opts[:search_label] || "Search"
    processing = opts[:processing] || "Processing"
    persist_state = opts[:persist_state].present? ? opts[:persist_state].to_s : "true"
    table_dom_id = opts[:table_dom_id] ? "##{opts[:table_dom_id]}" : ".datatable"
    per_page = opts[:per_page] || opts[:display_length]|| 25
    no_records_message = opts[:no_records_message] || nil
    auto_width = opts[:auto_width].present? ? opts[:auto_width].to_s : "true"
    row_callback = opts[:row_callback] || nil
    draw_callback = opts[:draw_callback] || nil
    server_method = opts[:server_method] || "GET"

    append = opts[:append] || nil

    ajax_source = opts[:ajax_source] || nil
    server_side = opts[:ajax_source].present?

    additional_data_string = ""
    additional_data.each_pair do |name,value|
      additional_data_string = additional_data_string + ", " if !additional_data_string.blank? && value
      additional_data_string = additional_data_string + "{'name': '#{name}', 'value':'#{value}'}" if value
    end

    %Q{
    <script type="text/javascript">
    $(function() {
        $('#{table_dom_id}').dataTable({
          "oLanguage": {
            "sSearch": "#{search_label}",
            #{"'sZeroRecords': '#{no_records_message}'," if no_records_message}
            "sProcessing": '#{processing}'
          },
          "sPaginationType": "full_numbers",
          "iDisplayLength": #{per_page},
          "bJQueryUI": true,
          "bProcessing": true,
          #{"'sAjaxSource': '#{ajax_source}'," if ajax_source}
          "sServerMethod": "#{server_method}",
          "bServerSide": #{server_side},
          "bLengthChange": false,
          "bStateSave": #{persist_state},
          "bFilter": #{search},
          "bAutoWidth": #{auto_width},
          #{"'aaSorting': [#{sort_by}]," if sort_by}
          "aoColumns": [
      			#{formatted_columns(columns)}
      				],
      		#{"'fnDrawCallback': function(oSettings) { #{draw_callback} }," if draw_callback}
      		#{"'fnRowCallback': function( nRow, aData, iDisplayIndex ) { #{row_callback} }," if row_callback}

        })#{append};
    });
    </script>
    }
  end

  private
    def formatted_columns(columns)
      i = 0
      columns.map {|c|
        i += 1
        if c.nil? or c.empty?
          "null"
        else
          searchable = c[:searchable].to_s.present? ? c[:searchable].to_s : "true"
          sortable = c[:sortable].to_s.present? ? c[:sortable].to_s : "true"
          
          base = "{
          'sType': '#{c[:type] || "string"}',
          'bSortable':#{sortable},
          'bSearchable':#{searchable}"
          
          suffix = "#{",'sClass':'#{c[:class]}'" if c[:class]}
          }"
          
          if c[:width].to_s.present?
            "#{base},
            'sWidth':'#{c[:width].to_s}px'#{suffix}"
          else
            "#{base}#{suffix}"
          end
        end
      }.join(",")
    end
>>>>>>> 528a84ac36f9ee8ae5ac92ad60e3b15c99db9827
end
