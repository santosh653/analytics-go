package analytics

var _ Message = Event(nil)

// This type represents any event type sent to the Tracking API as described in
// https://segment.com/docs/libraries/http/
type Event map[string]interface{}

func (msg Event) internal() {
	panic(unimplementedError)
}

func (msg Event) string(field string) string {
	val, _ := msg[field].(string)
	return val
}

func (msg Event) Validate() error {
	if typ, ok := msg["type"].(string); ok {
		switch typ {
		case "alias":
			return Alias{
				Type:       "alias",
				UserId:     msg.string("userId"),
				PreviousId: msg.string("previousId"),
			}.Validate()
		case "group":
			return Group{
				Type:        "group",
				UserId:      msg.string("userId"),
				AnonymousId: msg.string("anonymousId"),
				GroupId:     msg.string("groupId"),
			}.Validate()
		case "identify":
			return Identify{
				Type:        "identify",
				UserId:      msg.string("userId"),
				AnonymousId: msg.string("anonymousId"),
			}.Validate()
		case "page":
			return Page{
				Type:        "page",
				UserId:      msg.string("userId"),
				AnonymousId: msg.string("anonymousId"),
			}.Validate()
		case "screen":
			return Screen{
				Type:        "screen",
				UserId:      msg.string("userId"),
				AnonymousId: msg.string("anonymousId"),
			}.Validate()
		case "track":
			return Track{
				Type:        "track",
				UserId:      msg.string("userId"),
				AnonymousId: msg.string("anonymousId"),
				Event:       msg.string("event"),
			}.Validate()
		}
	}
	return FieldError{
		Type:  "analytics.Event",
		Name:  "Type",
		Value: msg["type"],
	}
}