var selectedColorOne = '#81fbbd'
var selectedColorTwo = '#ffa183'
var vectorMapLoader = function(){
  mapSelector = $('#vmap');
  mapSelectorWidth = parseInt(mapSelector.css('width'), 10);
  mapSelector.css('height', mapSelectorWidth / 1.5);
  mapSelector.vectorMap(
    {
      map: 'usa_en',
      backgroundColor: '#87cefa',
      selectedColor: selectedColorOne,
      hoverColor: '#ffc783',
      enableZoom: false,
      multiSelectRegion: true,
      selectedRegions: gon.states,
      onRegionClick: function(element, code, region)
      {
        window.location = window.location + "/marathons/new?state=" + code;
      }
    });

  $(document).on('click', '#matching_states', function(){
    if (this.checked)
      {
        $.each(gon.states_matching, function(index, value){
          jQuery('#vmap').vectorMap('setColors', value, selectedColorTwo) 
        })
      }
    else 
      {
        $.each(gon.states, function(index, value){
          jQuery('#vmap').vectorMap('setColors', value, selectedColorOne) 
        });
     }
  });

  $(document).on('click', '#marathons th a', function(){
    $.getScript(this.href);
    return false;
     });
  };

$(document).ready(vectorMapLoader);
$(document).on('page:load', vectorMapLoader);
