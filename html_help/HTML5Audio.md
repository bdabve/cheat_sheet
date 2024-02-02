# <center>HTML5 Audio</center>

## About Codecs

* The term `codec` stands for `encoder/decoder`. It describes the functionality provided by software that encodes and decodes media such as audio and video
* In HTML5 there are a number of different sets of codecs available, depending on the browser used.
* Codecs supported by the HTML5 `<audio>` tag:

| Codec | Description |
|-------|-------------|
| AAC   | This audio codec, which stands for `Advanced Audio Encoding`, is used by Apple's iTunes store, and is a proprietary patented technology supported by Apple, Google, and Microsoft, It generally uses the .aac file extension. Its mime type is `audio/aac`.|
| MP3   | This audio codec, which stands for MPEG Audio Layer 3, has been available for many years. While the term is often (incorrectly) used to refer to any type of digital audio, it is a proprietary patented technology that is supported by Apple, Google, Mozilla Firefox, and Microsoft. The file extension it uses is `.mp3.` Its mime type is `audio/mpeg` .
| PCM   | This audio codec, which stands for Pulse Coded Modulation, stores the full data as encoded by an analog-to-digital converter, and is the format used for storing data on audio CDs. Because it does not use compression, it is called a lossless codec and its files are generally many times larger than AAC or MP3 files. It is supported by Apple, Mozilla Firefox, and Opera. Usually this type of file has the extension `.wav` Its mime type is `audio/wav` , but you may also see `audio/wave` .
| Vorbis    | Sometimes referred to as Ogg Vorbis—because it generally uses the `.ogg` file extension this audio codec is unencumbered by patents and free of royalty payments. It is supported by Google Chrome, Mozilla Firefox, and Opera. Its mime type is `audio/ogg` , or sometimes `audio/oga` .

* The following list summarizes the major operating systems and browsers, along with the audio types their latest version support:
  * __Apple iOS__: AAC, MP3, PCM.
  * __Apple Safari__: AAC, MP3, PCM.
  * __Google Android__: 2.3+, AAC, MP3, Vorbis.
  * __Google Chrome__: AAC, MP3, Vorbis.
  * __Mincrosoft IE__: AAC, MP3.
  * __Mozilla Firefox__: MP3, PCM, Vorbis.
  * __Opera__: PCM, Vorbis.
