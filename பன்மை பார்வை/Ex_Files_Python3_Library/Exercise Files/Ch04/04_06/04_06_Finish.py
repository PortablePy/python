# Text Wrap Module
import textwrap

websiteText = """   Learning can happen anywhere with our apps on your computer,
mobile device, and TV, featuring enhanced navigation and faster streaming
for anytime learning. Limitless learning, limitless possibilities."""

print("No Dedent:")
print(textwrap.fill(websiteText))

print("Dedent")
dedent_text = textwrap.dedent(websiteText).strip()
print(dedent_text)

print("Fill")
print()
print(textwrap.fill(dedent_text, width=50))
print(textwrap.fill(dedent_text, width=100))

print("Controlling Indent")
print(textwrap.fill(dedent_text, initial_indent="   ", subsequent_indent="          "))

print("Shortening Text")
short = textwrap.shorten("LinkedIn.com is great!", width=15, placeholder="...")
print(short)