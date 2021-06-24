function zoom() {
  $('.zoom').show();

  var magnifierSize = 500;
  var magnification = 3;
  var zoomCenter = magnifierSize/2;

  var imageLeftSide = Math.round($(this).offset().left);
  var imageTopSide = Math.round($(this).offset().top);
  var imageRightSide = Math.round(imageLeftSide + $(this).width());
  var imageBottomSide = Math.round(imageTopSide + $(this).height());

  $('.zoom').css({
    'background-size': $(this).width() * magnification + 'px ' +
                       $(this).height() * magnification + "px",
    'background-image': 'url("' + $(this).attr('src') + '")',
    'width': magnifierSize,
    'height': magnifierSize
  });

  $(document).mousemove(function() {
    var margin = 3;
    var xMousePosition = event.pageX;
    var yMousePosition = event.pageY;

    if (xMousePosition < imageLeftSide - margin || xMousePosition > imageRightSide + margin ||
        yMousePosition < imageTopSide - margin|| yMousePosition > imageBottomSide + margin) {
      $('.zoom').hide();
      $(document).unbind('mousemove');
    }
    $('.zoom').css({
      'left': xMousePosition - zoomCenter,
      'top': yMousePosition - zoomCenter,
      'background-position': -((xMousePosition - imageLeftSide) * magnification - zoomCenter) + "px "
                           + -((yMousePosition - imageTopSide) * magnification - zoomCenter) + "px"
    });
  });
}

function hide_all() {
  $('#home_page').hide();
  $('#luoghi_home').hide();
  $('#persone_page').hide();
  $('#luoghi_page').hide();
  $('#istituzioni_page').hide();
  $('#glossario_page').hide();
  $('#testo_page').hide();
}

function choosePage(el) {
  hide_all();
  switch(el) {
    case '#ancora_antroponimi':
      $('#persone_page').show();
      break;
    case '#ancora_toponimi':
      $('#luoghi_page').show();
      break;
    case '#ancora_istituzioni':
      $('#istituzioni_page').show();
      break;
    case '#ancora_glossario':
      $('#glossario_page').show();
      break;
    case '#ancora_testo':
      $('#testo_page').show();
      break;
    default:
      $('#home_page').show();
      break;
  }
}

$( document ).ready(function() {
  $('.zoom').hide();
  choosePage(window.location.hash);
  $('.checkPage').each(function() {
    $(this).click( function() {
      choosePage($(this).attr("href"));
    });
  });
  $('img').each(function() {
    $(this).hover(zoom);
  });

});
