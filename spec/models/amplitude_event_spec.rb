require 'spec_helper'

describe AmplitudeEvent do
  describe "should_be_imported?" do
    context "the event type is in the allowed event list" do
      it "should return true" do
        create(:context)
        event = create(:event)
        event.stub(:event_type).and_return(event.allowed_event_types.first)
        expect(event.should_be_imported?).to be_true
      end
      context "the context should not be imported" do
        it "should return false" do
          event = create(:event)
          event.context.stub(:should_be_imported?).and_return false
          expect(event.should_be_imported?).to be_false
        end
      end
    end

    context "the event type is not in the list" do
      it "should return false" do
        event = create(:event, event_type: "foo")
        expect(event.should_be_imported?).to be_false
      end
    end

    context "the timestamp is misformed" do
      it "should return false" do
        event = create(:event, time: "foo")
        event.stub(:event_type).and_return(event.allowed_event_types.first)
        expect(event.should_be_imported?).to be_false
      end
    end
  end
end
