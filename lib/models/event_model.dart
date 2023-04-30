class EventModel {
  final String eventId;
  final String ownerId;
  final String eventTitle; // max 30 char and can't be empty
  final String eventDescription; // max 255 char can be empty
  final int maximumPeople; // max 20
  final List<String> tags; // max 10 // need to change in doc
  final AgeRestrictionModel ageRestriction;
  final DateTime dateCreated;
  final DateOfEventModel dateOfEvent;
  final LocationModel location;
  final List<String> images; // Array of Base64 String
  final List<String> joinedUsers = []; // list of userId String

  EventModel({
    required this.eventId,
    required this.ownerId,
    required this.eventTitle,
    required this.eventDescription,
    required this.maximumPeople,
    required this.tags,
    required this.ageRestriction,
    required this.dateCreated,
    required this.dateOfEvent,
    required this.location,
    required this.images,
  });

  Map<String, dynamic> toJSON() {
    return {
      'event_id': eventId,
      'owner_id': ownerId,
      'event_title': eventTitle,
      'event_description': eventDescription,
      'maximum_people': maximumPeople,
      'tags': tags,
      'age_restriction': ageRestriction.toJSON(),
      'date_created': dateCreated.toIso8601String(),
      'date_of_event': dateOfEvent.toJSON(),
      'location': location.toJSON(),
      'images': images,
      'joined_users': joinedUsers,
    };
  }
}

class AgeRestrictionModel {
  final int minimumAge;
  final int maximumAge;

  AgeRestrictionModel({
    required this.minimumAge,
    required this.maximumAge,
  });

  Map<String, dynamic> toJSON() {
    return {
      'minimum_age': minimumAge,
      'maximum_age': maximumAge,
    };
  }
}

class DateOfEventModel {
  final DateTime start;
  final DateTime end;

  DateOfEventModel({
    required this.start,
    required this.end,
  });

  Map<String, dynamic> toJSON() {
    return {
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
    };
  }
}

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJSON() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
