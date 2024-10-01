// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VideoUpload {

    // Structure to store video details
    struct Video {
        string videoHash;
        string caption;
        string tag;
        address uploader;
        uint256 timestamp;
    }

    // Mapping from video ID to Video details
    mapping(uint256 => Video) public videos;

    // Video counter to generate a unique ID for each video
    uint256 public videoCount;

    // Event to log the video upload
    event VideoUploaded(
        uint256 indexed videoId,
        string videoHash,
        string caption,
        string tag,
        address indexed uploader,
        uint256 timestamp
    );

    // Function to upload video metadata
    function uploadVideo(string memory _videoHash, string memory _caption, string memory _tag) public {
        // Increment the video count
        videoCount++;

        // Store video details in the mapping
        videos[videoCount] = Video({
            videoHash: _videoHash,
            caption: _caption,
            tag: _tag,
            uploader: msg.sender,
            timestamp: block.timestamp
        });

        // Emit the VideoUploaded event
        emit VideoUploaded(videoCount, _videoHash, _caption, _tag, msg.sender, block.timestamp);
    }

    // Function to get video details by ID
    function getVideo(uint256 _videoId) public view returns (string memory, string memory, string memory, address, uint256) {
        Video memory v = videos[_videoId];
        return (v.videoHash, v.caption, v.tag, v.uploader, v.timestamp);
    }
}
