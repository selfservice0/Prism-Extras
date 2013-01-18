

$(function(){
    $('#frm-search').submit(function(){
        $.post('query.php', $(this).serialize(), function(resp){
            $('.text-error').remove();
            if(resp.results.length > 0){
                $('.table tbody td').remove();
                for(r in resp.results){

                    data = resp.results[r].data;

                    if(typeof resp.results[r].data == "object"){;
                        data = "";
                        $.each(resp.results[r].data, function(k,v){
                            data += k + ": " + v + "<br/>";
                        });
                    }

                    var tr = '<tr>';
                    tr += '<td>'+resp.results[r].world+'</td>';
                    tr += '<td>'+resp.results[r].x+' '+resp.results[r].y+' '+resp.results[r].z+'</td>';
                    tr += '<td>'+resp.results[r].action_type+'</td>';
                    tr += '<td>'+resp.results[r].player+'</td>';
                    tr += '<td>'+data+'</td>';
                    tr += '<td>'+resp.results[r].action_time+'</td>';
                    tr += '</tr>'

                    $('.table tbody').append(tr);
                }
            } else {
                $('button').after('<span class="text-error">No results found. Try again.</span>')
            }
        }, 'json');
        return false;
    }).trigger('submit');
});