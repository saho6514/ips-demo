import json, urllib.request, os

API_KEY = "sk_0b00f8a3bb9de0bb32bf1a9555c1cab4ba63e1dcda129b9b"
VOICE_ID = "ZSNL4hPqCnqoMPaI4jGX"

scripts = {
    "oms-s0": "Hoyt, what you described to us is textbook field friction. Your outside reps have no order visibility — they call the office, someone looks it up in S A P for Acorn or EIS for Smith Drain, and relays it back. That takes time neither side has. And when a rep tries to submit a new order, they're often entering it twice: once in Salesforce, once directly in the ERP. You mentioned the idea of just giving reps S A P access. That's a reasonable starting point — but it only solves half the problem. Smith Drain runs on Progress, not S A P. Your reps would still be managing two systems, two logins, no unified view. What we're about to show you works with the infrastructure MGI already has — Salesforce CRM and the community portal your team is already building — and extends it to give every rep one place for every order, regardless of which ERP it lives in. Click 'One Window, Both ERPs' to see what that looks like in practice.",

    "oms-s1": "Order Management for Salesforce sits in front of your ERPs — it doesn't replace them. S A P remains the system of record for Acorn. EIS and Progress remain the system of record for Smith Drain. Nothing changes in either ERP. What changes is what your reps see. From your team's community portal — the one already in progress — reps get a single order view. Acorn orders, Smith Drain orders, all of it in one place. When they submit a new order, OMS routes it to the right ERP automatically, based on rules you set. The rep doesn't decide which system gets the order. They don't need two logins. They just enter the order. We've seen this architecture work. Another large manufacturer running multiple ERP systems used OMS as the central routing layer — same model as what MGI would be building here. Click 'Where's My Order' to see the agentic capability.",

    "oms-s2": "Here's where this becomes real for the field. A rep is on-site with a customer. They want to know the status on the Fisher Controls order. Instead of calling the office, they send a message: 'Where's the Fisher Controls order?' Agentforce looks it up — across both ERPs, through OMS — and responds directly. Status, estimated ship date, and if there's a delay, an offer to reroute. No one picks up the phone. No one swivels between S A P and EIS. The rep has an answer in seconds. The underlying capability — WISMO, returns, RMA, cancellations — is available through an AppExchange package. This isn't a large implementation. It's additive to what MGI already has. Your team doesn't build it from scratch — they install it and configure it on top of the Salesforce environment that's already there. Click 'How It Routes' to see the rules engine behind this.",

    "oms-s3": "The routing logic is where a lot of customers get nervous — they assume this requires S A P development, ERP configuration changes, something heavyweight. It doesn't. OMS has a rules engine that sits entirely on Salesforce. When an order comes in, it looks at the product line, the business unit, the geography — and routes to S A P or EIS accordingly. Business users can see those rules and adjust them. It's flows, not custom code. Your team works in tools they already know. No S A P developer required. And to answer the question your leadership is likely to ask — 'Why not just give reps S A P access?' — S A P access doesn't solve Smith Drain. It doesn't give reps a single portal. It doesn't give you an agentic interaction layer. OMS does all three, without touching your ERPs. This is what getting more out of what you have looks like in practice. MGI already owns the Salesforce infrastructure. OMS extends it to solve a problem S A P alone can't."
}

os.makedirs(".", exist_ok=True)

for filename, text in scripts.items():
    print(f"Generating {filename}.mp3 ...")
    payload = json.dumps({
        "text": text,
        "model_id": "eleven_turbo_v2_5",
        "voice_settings": {"stability": 0.45, "similarity_boost": 0.85}
    }).encode("utf-8")

    req = urllib.request.Request(
        f"https://api.elevenlabs.io/v1/text-to-speech/{VOICE_ID}",
        data=payload,
        headers={
            "xi-api-key": API_KEY,
            "Content-Type": "application/json",
            "Accept": "audio/mpeg"
        }
    )
    with urllib.request.urlopen(req) as resp:
        audio_bytes = resp.read()

    out_path = f"{filename}.mp3"
    with open(out_path, "wb") as f:
        f.write(audio_bytes)
    print(f"  → {out_path} ({len(audio_bytes):,} bytes)")

print("Done.")
