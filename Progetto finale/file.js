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

function choosePage(el) {
  switch(el) {
    case '#ancora_antroponimi':
      $('#persone_page').show();
      $('#luoghi_page').hide();
      $('#istituzioni_page').hide();
      $('#testo_page').hide();
      break;
    case '#ancora_toponimi':
      $('#persone_page').hide();
      $('#luoghi_page').show();
      $('#istituzioni_page').hide();
      $('#testo_page').hide();
      break;
    case '#ancora_istituzioni':
      $('#persone_page').hide();
      $('#luoghi_page').hide();
      $('#istituzioni_page').show();
      $('#testo_page').hide();
      break;
    default:
      $('#persone_page').hide();
      $('#luoghi_page').hide();
      $('#istituzioni_page').hide();
      $('#testo_page').show();
      break;
  }
}

$( document ).ready(function() {

  var el;
  if (window.location.hash != "")
    el = window.location.hash;
  else
    el = '#testo_page';
  choosePage(el);

  $('.zoom').hide();

  $('.checkPage').each(function() {
    $(this).click( function() {
      choosePage($(this).attr("href"));
    });
  });

  $('img').each(function() {
    $(this).hover(zoom);
  });

});
