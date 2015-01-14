require 'spec_helper'

describe AmplitudeEvent do
  describe "should_be_imported?" do
    context "the event type is in the allowed event list" do
      it "should return true" do
        event = AmplitudeEvent.new({}, {})
        event.stub(:event_type).and_return(event.allowed_event_types.first)
        event.stub(:time).and_return(12)
        expect(event.should_be_imported?).to be_true
      end
    end

    context "the event type is not in the list" do
      it "should return false" do
        event = AmplitudeEvent.new({}, {})
        event.stub(:event_type).and_return("foo")
        expect(event.should_be_imported?).to be_false
      end
    end

    context "the timestamp is misformed" do
      it "should return false" do
        event = AmplitudeEvent.new({"event_type" => "added_second_block_walkthrough", "timestamp" => "foo"}, {})
        event.stub(:event_type).and_return(event.allowed_event_types.first)
        expect(event.should_be_imported?).to be_false
      end
    end
  end
end
