class RenamePlayersPaidToPlacesPaidInPayoutLines < ActiveRecord::Migration[6.0]
  def change
    rename_column(:payout_lines, :players_paid, :places_paid)
  end
end
