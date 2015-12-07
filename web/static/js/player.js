let Player = {
  player: null,

  init (domId, playerId) {
    window.onYouTubeIframeAPIReady = () => this.onIframeReady(domId, playerId)
    let youtubeScriptTag = document.createElement('script')
    youtubeScriptTag.src = '//www.youtube.com/iframe_api'
    document.head.appendChild(youtubeScriptTag)
  },

  onIframeReady (domId, playerId) {
    this.player = new YT.Player(domId, {
      height: '360',
      width: '420',
      videoId: playerId,
      events: {
        'onReady': event => this.onPlayerReady(event),
        'onStateChange': event => this.onPlayerStateChange
      }
    })
  },

  onPlayerReady (event) { /* this.player.playVideo() */ },

  onPlayerStateChange (event) {},
  getCurrentTime () {
    try {
      return Math.floor(this.player.getCurrentTime() * 1000)
    } catch (e) {
      return 0
    }
  },
  seekTo (millsec) { return this.player.seekTo(millsec / 1000) }
}

export default Player
