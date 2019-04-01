require 'digest/md5'

class MailChimp

  def list_id
    ENV['MAILCHIMP_LIST_ID']
    #MC_LIST_ID
  end

  def segments
    mc('list_static_segments')
  end

  def members
    mc('list_members')
  end

  def create_segment(segment)
    mc('list_static_segment_add', name: segment.name)
  end

  def delete_segment(segment)
    mc('list_static_segment_del', seg_id: segment.mail_chimp_id)
  end

  def subscribe_to_segment(email, segment, merge_vars)
    first_name = merge_vars[:name].split(" ").first
    last_name = merge_vars[:name].split(" ").last
    mailchimp = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'], symbolize_keys: true)
    email_md5 = Digest::MD5.hexdigest(email)
    mailchimp.lists(list_id)
      .members(email_md5)
      .upsert(body: {
      email_address: email,
      status: "subscribed",
      merge_fields: {
        FNAME: first_name,
        LNAME: last_name,
        NAME: merge_vars[:name],
        RADIOYUI_: merge_vars[:cycle],
        SELECTYUI: merge_vars[:state_code]},
      double_optin: false,
      update_existing: true,
      send_welcome: true})
    mailchimp.lists(list_id)
      .members(email_md5)
      .tags
      .create(body: {tags: [{name: segment.name, status: 'active'}]})
    return true
  end

  def subscribe(email, merge_vars)
    mc('list_subscribe', {
      email_address: email,
      merge_vars: merge_vars,
      double_optin: false,
      update_existing: true,
      send_welcome: true
    })
  end

  def add_to_segment(email, segment)
    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'], symbolize_keys: true)
    #debugger
    list_id = 660481
    #http://codegists.com/code/mailchimp-api-3.0-send-email/
    # note below the gibbon was originally gb
    emails_added = gibbon.list_static_segment_members_add( :id => list_id,
                                                          :seg_id => segment.mail_chimp_id,
                                                          :batch => [email] )

    # mc('list_static_segment_members_add',
    #    seg_id: segment.mail_chimp_id,
    #    batch: [email]
    #   )
    #gibbon.lists(list_id).members.create(body: {email_address: "foo@bar.com", status: "subscribed", merge_fields: {FNAME: "First Name", LNAME: "Last Name"}})

  end

  private

  def mc(message, args={})
    #Gibbon.new.send(message, {id: list_id, api_key: ENV['MAILCHIMP_API_KEY']}.merge(args))
    gibbon = Gibbon::Request.new(api_key: ENV['MAILCHIMP_API_KEY'], symbolize_keys: true)
  end
end
