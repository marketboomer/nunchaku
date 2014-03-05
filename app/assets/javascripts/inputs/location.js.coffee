$ ->
  maps = $(".input.map")

  if maps.length
    el = maps[0]
    form = $(el).closest('form')
    map = new google.maps.Map(el,
      zoom: 14
      autoZoom: false
      mapTypeId: google.maps.MapTypeId.ROADMAP
    )

    magic_marker = (position) ->
      map.setCenter(position)

      marker = new google.maps.Marker
        position: position
        map: map 
        draggable: true

      form.submit (e) ->
        e.preventDefault()

        position = marker.getPosition()
        geocoder = new google.maps.Geocoder()
        geocoder.geocode latLng: position, (results, status) ->
          if status == google.maps.GeocoderStatus.OK
            if results[0]
              form.find('input[id$="latitude"]').val(position.lat())
              form.find('input[id$="longitude"]').val(position.lng())
              form.find('input[id$="address"]').val(results[0].formatted_address)

              form[0].submit()

    lookup_client_location = ->
      if google.loader.ClientLocation
        position = new google.maps.LatLng(
          google.loader.ClientLocation.latitude,
          google.loader.ClientLocation.longitude
        )

        magic_marker(position)

      else
        geocoder = new google.maps.Geocoder()
        geocoder.geocode address: 'Melbourne, VIC', (results, status) ->
          if status == google.maps.GeocoderStatus.OK
            magic_marker(results[0].geometry.location)

    current_lat = form.find('input[id$="latitude"]').val()
    current_lon = form.find('input[id$="longitude"]').val()

    if current_lat and current_lon
      position = new google.maps.LatLng(parseFloat(current_lat), parseFloat(current_lon))
      magic_marker(position)
    else if navigator.geolocation
      # use html5 geolocation api
      success = (position) ->
        position = new google.maps.LatLng(
          position.coords.latitude,
          position.coords.longitude
        )

        magic_marker(position)

      navigator.geolocation.getCurrentPosition(success, lookup_client_location)
    else
      lookup_client_location()
