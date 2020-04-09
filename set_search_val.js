// https://plainjs.com/javascript/events/trigger-an-event-11/
function triggerEvent(el, url, type){
   if ('createEvent' in document) {
        // modern browsers, IE9+
        var audio= new Audio(url); 
        audio.play();
        var e = document.createEvent('HTMLEvents');
        e.initEvent(type, false, true);
        el.dispatchEvent(e);

    } else {
        // IE 8
        var e = document.createEventObject();
        e.eventType = type;
        el.fireEvent('on'+e.eventType, e);
        var audio= new Audio('https://file-examples.com/wp-content/uploads/2017/11/file_example_MP3_700KB.mp3'); 
        audio.play();
    }
}

function set_search_val( value, soundurl ) {
  var el = document.querySelector('#DataTables_Table_0_filter > label > input[type="search"]');
  el.value = value;
  triggerEvent(el, soundurl, 'keyup');
}