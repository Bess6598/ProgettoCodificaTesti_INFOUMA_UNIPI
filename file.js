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
    var margin = 1;
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
};

$( document ).ready(function() {
  $('.zoom').hide();
  $('img').each(function() {
    $(this).hover(zoom);
  });
});
