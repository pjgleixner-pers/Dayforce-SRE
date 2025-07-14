#Install python3.13 -m pip install requests before running
import requests
from typing import TypedDict, NotRequired

class BreedData(TypedDict):
    breed_name: str
    sub_breed_name: str | None

def get_all_dog_breeds() -> dict[str, list[str]]:
    """Retrieve all dog breeds from the Dog API"""
    response = requests.get('https://dog.ceo/api/breeds/list/all')
    response.raise_for_status()  # Raises HTTPError for bad responses
    return response.json()['message']

def flatten_breeds(breeds_data: dict[str, list[str]]) -> list[BreedData]:
    """Flatten the nested breed/sub-breed structure into a list of dictionaries"""
    return [
        {'breed_name': breed, 'sub_breed_name': sub_breed or None}
        for breed, sub_breeds in breeds_data.items()
        for sub_breed in ([None] if not sub_breeds else sub_breeds)
    ]

async def async_main():
    """Asynchronous version using httpx for better performance"""
    try:
        import httpx
        async with httpx.AsyncClient() as client:
            print("Fetching dog breeds from API asynchronously...")
            response = await client.get('https://dog.ceo/api/breeds/list/all')
            response.raise_for_status()
            breeds_data = response.json()['message']
            
            flattened = flatten_breeds(breeds_data)
            
            print("\nSample of flattened data (first 5 items):")
            for item in flattened[:5]:
                print(item)
                
            print(f"\nTotal breeds processed: {len(flattened)}")
            return flattened
            
    except ImportError:
        print("httpx not available, falling back to synchronous version")
        return main()
    except Exception as e:
        print(f"An error occurred: {e}")

def main() -> list[BreedData]:
    try:
        print("Fetching dog breeds from API...")
        breeds_data = get_all_dog_breeds()
        
        print("Processing data...")
        flattened_breeds = flatten_breeds(breeds_data)
        
        print("\nSample of flattened data (first 5 items):")
        for item in flattened_breeds[:5]:
            print(item)
            
        print(f"\nTotal breeds processed: {len(flattened_breeds)}")
        return flattened_breeds
        
    except Exception as e:
        print(f"An error occurred: {e}")
        return []

if __name__ == "__main__":
    import asyncio
    # Try async version first, fall back to sync if needed
    asyncio.run(async_main()) or main()