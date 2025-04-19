# Service Object for setting the priority of topic bids
class ReviewBidPriorityService
  # Runs the review bidding algorithm by sending data to the web service
  # @param participant_id [Integer] The ID of the participant submitting review bids
  # @param selected_topic_ids [Array, nil] TThe array of selected topic ids
  # @return [void]
  def self.process_bids(assignment_id, signed_up_topics)
    signed_up_topics.each do |topic|
      ReviewBid.where(signuptopic_id: topic, participant_id: params[:id]).destroy_all
    end
    params[:topic].each_with_index do |topic_id, index|
      bid_existence = ReviewBid.where(signuptopic_id: topic_id, participant_id: params[:id])
      if bid_existence.empty?
        ReviewBid.create(priority: index + 1, signuptopic_id: topic_id, participant_id: params[:id], assignment_id: assignment_id)
      else
        ReviewBid.where(signuptopic_id: topic_id, participant_id: params[:id]).update_all(priority: index + 1)
      end
    end
  end
end 