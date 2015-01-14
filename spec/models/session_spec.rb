require 'spec_helper'

describe Session do
  describe "should_be_imported" do
    context "the context should be imported" do
      context "events are populated" do
        it "should be imported" do
          session = Session.new({})
          session.events = [build(:event)]
          expect(session.should_be_imported?).to be_true
        end
      end

      context "events are not populated" do
        it "should not be imported" do
          session = Session.new({})
          expect(session.should_be_imported?).to be_false
        end
      end
    end
  end
end
