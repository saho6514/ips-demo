#!/bin/bash
# Run from the agentforce-sims/ directory.
# Generates narration mp3s for all 6 sims via ElevenLabs.

API_KEY="43f4c2e5c1325adb68a8748c9857ac86f1bad13d9e1755dcff44747fbe19ff58"
VOICE_ID="ZSNL4hPqCnqoMPaI4jGX"
MODEL="eleven_multilingual_v2"
DIR="$(cd "$(dirname "$0")" && pwd)"

generate() {
  local name="$1"
  local text="$2"
  local out="$DIR/${name}-narration.mp3"
  echo "Generating ${name}..."
  curl -s -X POST "https://api.elevenlabs.io/v1/text-to-speech/${VOICE_ID}" \
    -H "xi-api-key: ${API_KEY}" \
    -H "Content-Type: application/json" \
    -d "{\"text\":$(echo "$text" | python3 -c 'import json,sys; print(json.dumps(sys.stdin.read()))'),\"model_id\":\"${MODEL}\",\"voice_settings\":{\"stability\":0.5,\"similarity_boost\":0.75}}" \
    --output "$out"
  echo "  → saved to ${out}"
}

generate "scopely" "Scopely's biggest revenue risk is lapsed players — and the re-engagement window closes in hours, not days. What you're about to see is a VP of Monetization go straight to Slack, describe a campaign brief in plain language, and watch Agentforce deploy forty-seven thousand personalized journeys in under three minutes. No one opens Marketing Cloud. No analyst builds a segment. No workflow tool fires up. Agentforce builds the intelligence. Slack delivers it at human scale. And because this runs through Slack on Enterprise Plus, every one of those forty-seven thousand deployments happened at zero marginal cost. One conversation. One judgment call. Forty-seven thousand players back in the funnel before the lapse window closes."

generate "mobileone" "For a carrier retailer, iPhone launch day is a forty-eight-hour window — and the stores that run out first lose the quarter. Commerce Cloud OMS runs headlessly, monitoring live inventory across every distribution center around the clock. No dashboard. No morning standup. No analyst running reports. When three San Diego stores came up ninety-one units short before nine AM, Store Pulse had the gap flagged, the routing plan staged, and the decision in Marcus's Slack before a single customer was turned away. No browser required. The API ran the operation. Marcus made one call. Ninety-one units rerouted. Every customer served."

generate "turntide" "Turntide's competitive edge is the intelligence inside their motors — real-time performance data that tells the story of every installation. The problem: that data lives in an ops system no one in sales ever opens. Marketing Cloud Next changes that. Motor telemetry flows directly into MCN via API — no ETL project, no analyst, no data warehouse. That's the on-ramp. And once it's in, Agentforce runs headlessly: spotting the accounts whose hardware is quietly degrading, surfacing proactive service and renewal conversations in Slack before the customer picks up the phone to complain. The data was always Turntide's advantage. Now it automatically drives action."

generate "niantic" "Niantic's enterprise pipeline problem wasn't a lack of demand — it was a lack of connection. Scaniverse had hundreds of enterprise accounts actively scanning, and every one of them was a buying signal. The data was just never connected to CRM. Marketing Cloud Next runs headlessly against product telemetry around the clock — no analyst needed to pull the report. When Pipeline Scout found three hundred forty accounts with zero sales contact, it didn't wait for a QBR. Personalized outreach staged for two hundred ninety-seven accounts automatically. Defense accounts flagged for specialist routing. Derek reviewed once, replied once. Two-point-one million dollars of pipeline — out of dark, into motion."

generate "bright" "In professional services, unbilled scope creep doesn't announce itself. It builds across change orders, revision rounds, and out-of-scope requests until the billing window closes and the revenue is gone. Revenue Cloud Advanced runs headlessly across every active engagement — not just the ones your PMs are watching, all of them. When Margin Watch surfaced forty-six thousand dollars of scope creep at Naturium on day sixty-three, Rachel already had the contract language, the change order trail, and the dollar amounts. She spent ninety seconds. She absorbed forty-two hundred dollars as a goodwill gesture and recovered forty-one thousand six hundred dollars. The machine found it. The human made the call."

generate "ips" "For IPS, Ferguson isn't just a customer — they're the account that signals how IPS treats every distributor. A backorder notice on a three-hundred-thousand-dollar stocking order isn't just a fulfillment miss. It's a signal about reliability. Commerce Cloud OMS runs headlessly, watching every distributor order the moment it lands, cross-checking inventory across all distribution centers in real time. No browser. No spreadsheet. No ops standup. When Channel Watch flagged four unfulfillable SKUs on the Ferguson order, the three-DC routing plan was already staged. Sarah approved in ninety seconds. Ferguson got a complete shipment. That's Headless 360 for B2B commerce — reliability built into the infrastructure, not the inbox."

echo ""
echo "Done. All 6 narration files generated."
