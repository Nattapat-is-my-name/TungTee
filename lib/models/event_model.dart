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
  final List<String> joinedUsers; // list of userId String

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
    required this.joinedUsers,
  });
}

class AgeRestrictionModel {
  final int minimumAge;
  final int maximumAge;

  AgeRestrictionModel({
    required this.minimumAge,
    required this.maximumAge,
  });
}

class DateOfEventModel {
  final DateTime start;
  final DateTime end;

  DateOfEventModel({
    required this.start,
    required this.end,
  });
}

class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({
    required this.latitude,
    required this.longitude,
  });
}
