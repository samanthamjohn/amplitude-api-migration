require 'spec_helper'

describe Session do
  describe "should_be_imported" do
    context "the context should be imported" do
      context "events are populated" do
        it "should be imported" do
          session = create(:session, events: [create(:amplitude_event)])
          expect(session.should_be_imported?).to be_true
        end
      end

      context "events are not populated" do
        it "should not be imported" do
          session = create(:session, events: [])
          expect(session.should_not_be_imported?).to be_true
        end
      end
    end
  end
end
